import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire/functions/google_sign_in.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:ui';

import '../main.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    bool isLoading = false;

    var usernameController = TextEditingController();
    var passwordController = TextEditingController();
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Form(
        key: _formKey,
        child: ListView(
          children: [
            Container(
                decoration: BoxDecoration(color: Colors.orange[300]),
                width: window.physicalSize.width,
                height: window.physicalSize.height / 5.0,
                margin: const EdgeInsets.only(bottom: 32.0),
                child: Padding(
                    padding: const EdgeInsets.only(top: 24.0),
                    child: Center(
                        child: Image.network(
                            "https://i.ibb.co/M2YqRqs/logo.png",
                            height: 200,
                            width: 200)))),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
              child: Material(
                elevation: 5.0,
                color: Colors.white,
                borderRadius: BorderRadius.circular(100.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100.0),
                  child: Container(
                    padding: const EdgeInsets.only(left: 20.0),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                    ),
                    child: TextFormField(
                        style: const TextStyle(color: Colors.black),
                        validator: (value) {
                          if (value == "") {
                            return "Field is required";
                          }
                          return null;
                        },
                        controller: usernameController,
                        decoration: InputDecoration(
                            fillColor: Colors.white,
                            border: InputBorder.none,
                            icon: const Icon(Icons.person, color: Colors.black),
                            hintText: 'Enter username',
                            hintStyle: Theme.of(context).textTheme.bodyText1)),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Material(
                elevation: 5.0,
                borderRadius: BorderRadius.circular(100.0),
                color: Colors.white,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100.0),
                  child: Container(
                    padding: const EdgeInsets.only(left: 20.0),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                    ),
                    child: TextFormField(
                        style: const TextStyle(color: Colors.black),
                        validator: (value) {
                          if (value == "") {
                            return "Field is required";
                          }
                          return null;
                        },
                        controller: passwordController,
                        decoration: InputDecoration(
                            fillColor: Colors.white,
                            border: InputBorder.none,
                            icon:
                                const Icon(Icons.password, color: Colors.black),
                            hintText: 'Enter password',
                            hintStyle: Theme.of(context).textTheme.bodyText1),
                        obscureText: true),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Material(
                        elevation: 5.0,
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(100.0),
                        child: ElevatedButton.icon(
                          style: TextButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0)),
                              minimumSize: const Size(386, 48),
                              maximumSize: const Size(600, 400),
                              textStyle: const TextStyle(fontSize: 20),
                              backgroundColor: Colors.orange[300]),
                          onPressed: () async {
                            final SharedPreferences account =
                                await SharedPreferences.getInstance();
                            account.setString('email', usernameController.text);
                            if (_formKey.currentState!.validate() == true) {
                              signIn(usernameController.text,
                                  passwordController.text, context);
                            }
                          },
                          icon: const Icon(Icons.email),
                          label: const Text('Login via account'),
                        ),
                      )),
                  Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: Material(
                        elevation: 5.0,
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(100.0),
                        child: ElevatedButton.icon(
                          style: TextButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0)),
                              minimumSize: const Size(386, 48),
                              maximumSize: const Size(600, 400),
                              textStyle: const TextStyle(fontSize: 20),
                              backgroundColor: Colors.orange[300]),
                          onPressed: () async {
                            // if (_formKey.currentState!.validate() == true) {
                            //   signIn(usernameController.text,
                            //       passwordController.text, context);
                            // }
                            final SharedPreferences sharedPreferences =
                                await SharedPreferences.getInstance();
                            sharedPreferences.setString(
                                'email', usernameController.text);
                            setState(() {
                              finalemail =
                                  sharedPreferences.getString('email')!;
                            });
                            FirebaseService service = FirebaseService();
                            try {
                              await service.signInwithGoogle();
                              Navigator.pushNamedAndRemoveUntil(
                                  context, '/dashboard', (route) => false);
                            } catch (e) {
                              if (e is FirebaseAuthException) {
                                print(e.message!);
                              }
                            }
                          },
                          icon: const FaIcon(FontAwesomeIcons.google),
                          label: const Text('Login via Google'),
                        ),
                      )),
                  Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 0.0, horizontal: 0.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text("Dont have an account yet? "),
                          TextButton(
                            style: TextButton.styleFrom(
                                fixedSize: const Size(10, 10),
                                backgroundColor: Colors.transparent),
                            onPressed: () {
                              Navigator.pushNamed(context, '/signup');
                            },
                            child: const Text('Sign-up'),
                          ),
                        ],
                      ))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
