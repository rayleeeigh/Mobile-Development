import 'dart:math';

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutterfire/pages/dashboard.dart';
import 'package:flutterfire/pages/signup.dart';
import 'package:fluttertoast/fluttertoast.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(App());
}

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  bool _initialized = false;
  bool _error = false;

  void initializeFlutterFire() async {
    try {
      await Firebase.initializeApp();
      setState(() {
        _initialized = true;
      });
    } catch (e) {
      setState(() {
        _error = true;
      });
    }
  }

  @override
  void initState() {
    initializeFlutterFire();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (_error) {
      return errorHandle();
    }
    if (!_initialized) {
      return progressHandle();
    }

    return MaterialApp(
        theme: ThemeData(
            brightness: Brightness.dark, primarySwatch: Colors.orange),
        home: Builder(builder: (context) {
          return initialized(context);
        }));
  }
}

Widget errorHandle() {
  return const Directionality(
      textDirection: TextDirection.ltr, child: Text('There is an error'));
}

Widget progressHandle() {
  return const Directionality(
      textDirection: TextDirection.ltr,
      child: Text('This is a progress bar section'));
}

Widget initialized(BuildContext context) {
  final _formKey = GlobalKey<FormState>();

  var usernameController = TextEditingController();
  var passwordController = TextEditingController();

  return Stack(
    children: <Widget>[
      Positioned(
        child: Image.network(
          'https://iphone11papers.com/wp-content/uploads/papers.co-bj56-art-wood-mountain-digital-day-41-iphone-wallpaper-240x519.jpg',
          fit: BoxFit.cover,
          height: double.infinity,
          width: double.infinity,
        ),
      ),
      Scaffold(
        backgroundColor: Colors.black.withOpacity(0.6),
        body: Form(
          key: _formKey,
          child: Column(
            children: [
              Padding(
                  padding: const EdgeInsets.only(top: 50.0),
                  child: Center(
                      child: Image.network(
                          "https://i.ibb.co/zFpXYwL/pngwing-com.png",
                          height: 200,
                          width: 200))),
              Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: TextFormField(
                    validator: (value) {
                      if (value == "") {
                        return "Field is required";
                      }
                      return null;
                    },
                    controller: usernameController,
                    decoration: const InputDecoration(
                        label: Text("Username"),
                        icon: Icon(Icons.person),
                        hintText: 'Enter username'),
                  )),
              Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: TextFormField(
                      validator: (value) {
                        if (value == "") {
                          return "Field is required";
                        }
                        return null;
                      },
                      controller: passwordController,
                      decoration: const InputDecoration(
                          label: Text("Password"),
                          icon: Icon(Icons.password),
                          hintText: 'Enter password'),
                      obscureText: true)),
              Row(
                children: [
                  Padding(
                      padding: const EdgeInsets.only(top: 20.0, left: 20.0),
                      child: ElevatedButton(
                        style: TextButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0)),
                            minimumSize: const Size(160, 55),
                            maximumSize: const Size(600, 400),
                            textStyle: const TextStyle(fontSize: 20),
                            backgroundColor: Colors.orange[400]),
                        onPressed: () async {
                          if (_formKey.currentState!.validate() == true) {
                            signIn(usernameController.text,
                                passwordController.text, context);
                          }
                        },
                        child: const Text('Login'),
                      )),
                  Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: ElevatedButton(
                        style: TextButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0)),
                            minimumSize: const Size(160, 55),
                            maximumSize: const Size(600, 400),
                            textStyle: const TextStyle(fontSize: 20),
                            backgroundColor: Colors.orange[400]),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SignupPage()));
                        },
                        child: const Text('Sign-up'),
                      ))
                ],
              )
            ],
          ),
        ),
      ),
    ],
  );
}

signIn(String email, String password, BuildContext context) async {
  String errorMessage = "";
  try {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => DashboardPage()));
  } on FirebaseAuthException catch (e) {
    switch (e.code) {
      case "invalid-email":
        errorMessage = "Invalid email format";
        break;
      case "wrong-password":
        errorMessage = "Password is incorrect";
        break;
      case "user-not-found":
        errorMessage = "User not found";
        break;
      default:
        errorMessage = "An undefined Error happened.";
    }

    Fluttertoast.showToast(
        msg: errorMessage,
        gravity: ToastGravity.TOP,
        backgroundColor: Colors.red);
  }
}
