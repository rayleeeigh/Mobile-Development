import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:ui';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();

  var usernameController = TextEditingController();
  var passwordController = TextEditingController();
  var phonenumberController = TextEditingController();
  var confirmpasswordController = TextEditingController();
  PhoneNumber number = PhoneNumber(isoCode: 'PH');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Form(
        key: _formKey,
        child: ListView(
          children: [
            Container(
                decoration: BoxDecoration(color: Colors.orange[300]),
                width: window.physicalSize.width,
                height: window.physicalSize.height / 6.0,
                margin: const EdgeInsets.only(bottom: 32.0),
                child: Padding(
                    padding: const EdgeInsets.only(top: 50.0),
                    child: Center(
                        child: Image.network(
                            "https://i.ibb.co/M2YqRqs/logo.png",
                            height: 200,
                            width: 200)))),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
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
                        style: const TextStyle(color: Colors.grey),
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
                            icon: const Icon(Icons.person, color: Colors.grey),
                            hintText: 'Enter username',
                            hintStyle: Theme.of(context).textTheme.bodyText1)),
                  ),
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
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
                        style: const TextStyle(color: Colors.grey),
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
                                const Icon(Icons.password, color: Colors.grey),
                            hintText: 'Enter password',
                            hintStyle: Theme.of(context).textTheme.bodyText1),
                        obscureText: true),
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
                        style: const TextStyle(color: Colors.grey),
                        validator: (value) {
                          if (value == "") {
                            return "Field is required";
                          }
                          return null;
                        },
                        controller: confirmpasswordController,
                        decoration: InputDecoration(
                            fillColor: Colors.white,
                            border: InputBorder.none,
                            icon:
                                const Icon(Icons.password, color: Colors.grey),
                            hintText: 'Confirm Password',
                            hintStyle: Theme.of(context).textTheme.bodyText1),
                        obscureText: true),
                  ),
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
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
                    child: InternationalPhoneNumberInput(
                      onInputChanged: (PhoneNumber number) {
                        print(number.phoneNumber);
                      },
                      onInputValidated: (bool value) {
                        print(value);
                      },
                      selectorConfig: const SelectorConfig(
                        selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                      ),
                      ignoreBlank: false,
                      autoValidateMode: AutovalidateMode.disabled,
                      selectorTextStyle: const TextStyle(color: Colors.grey),
                      initialValue: number,
                      textFieldController: phonenumberController,
                      formatInput: false,
                      textStyle: const TextStyle(color: Colors.grey),
                      keyboardType: const TextInputType.numberWithOptions(
                          signed: true, decimal: true),
                      inputBorder:
                          const OutlineInputBorder(borderSide: BorderSide.none),
                      onSaved: (PhoneNumber number) {
                        print('On Saved: $number');
                      },
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 40.0),
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
                        child: ElevatedButton(
                          style: TextButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0)),
                              minimumSize: const Size(386, 50),
                              maximumSize: const Size(600, 400),
                              textStyle: const TextStyle(fontSize: 20),
                              backgroundColor: Colors.orange[300]),
                          onPressed: () async {
                            if (_formKey.currentState!.validate() == true) {
                              try {
                                await FirebaseAuth.instance
                                    .createUserWithEmailAndPassword(
                                        email: usernameController.text,
                                        password: passwordController.text);
                                Navigator.pushNamed(context, '/login');
                              } on FirebaseAuthException catch (e) {
                                if (e.code == 'user-not-found') {
                                  print('No user found for that email.');
                                } else if (e.code == 'wrong-password') {
                                  print(
                                      'Wrong password provided for that user.');
                                }
                              }
                            }
                          },
                          child: const Text('Sign-up'),
                        ),
                      )),
                  Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 0.0, horizontal: 0.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text("Already have an account?"),
                          TextButton(
                            style: TextButton.styleFrom(
                                fixedSize: const Size(10, 10),
                                backgroundColor: Colors.transparent),
                            onPressed: () {
                              Navigator.pushNamed(context, '/login');
                            },
                            child: const Text('Login'),
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
