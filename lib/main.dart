import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutterfire/pages/dashboard.dart';
import 'package:flutterfire/pages/signup.dart';

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
        body: Column(
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
                child: TextField(
                  controller: usernameController,
                  decoration: const InputDecoration(
                      label: Text("Username"),
                      icon: Icon(Icons.person),
                      hintText: 'Enter username'),
                )),
            Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextField(
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
                        try {
                          UserCredential userCredential = await FirebaseAuth
                              .instance
                              .signInWithEmailAndPassword(
                                  email: usernameController.text,
                                  password: passwordController.text);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const DashboardPage()));
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'user-not-found') {
                            print('No user found for that email.');
                          } else if (e.code == 'wrong-password') {
                            print('Wrong password provided for that user.');
                          }
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
    ],
  );
}
