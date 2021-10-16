import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutterfire/main.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();

  var usernameController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
                          controller: passwordController,
                          decoration: const InputDecoration(
                              label: Text("Password"),
                              icon: Icon(Icons.password),
                              hintText: 'Enter password'),
                          obscureText: true)),
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
                            try {
                              await FirebaseAuth.instance
                                  .createUserWithEmailAndPassword(
                                      email: usernameController.text,
                                      password: passwordController.text);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => App()));
                            } on FirebaseAuthException catch (e) {
                              if (e.code == 'user-not-found') {
                                print('No user found for that email.');
                              } else if (e.code == 'wrong-password') {
                                print('Wrong password provided for that user.');
                              }
                            }
                          }
                        },
                        child: const Text('Sign-up'),
                      ))
                ],
              )),
        ),
      ],
    );
  }
}
