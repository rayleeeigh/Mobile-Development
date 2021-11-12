import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutterfire/functions/google_sign_in.dart';
import 'package:flutterfire/pages/dashboard.dart';
import 'package:flutterfire/pages/login.dart';
import 'package:flutterfire/pages/profile.dart';
import 'package:flutterfire/pages/settings.dart';
import 'package:flutterfire/pages/signup.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'dart:ui';

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

  @override
  Widget build(BuildContext context) {
    if (!_initialized) {
      return progressHandle();
    }

    return MaterialApp(
        theme: ThemeData(
            brightness: Brightness.dark,
            primarySwatch: Colors.orange,
            textTheme: GoogleFonts.robotoSlabTextTheme(
              Theme.of(context).textTheme,
            )),
        initialRoute: '/login',
        routes: {
          '/login': (context) => const LoginPage(),
          '/signup': (context) => const SignupPage(),
          '/dashboard': (context) => const DashboardPage(),
          '/profile': (context) => const ProfilePage(),
          '/settings': (context) => const SettingsPage()
        });
  }

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

signIn(String email, String password, BuildContext context) async {
  String errorMessage = "";
  try {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    Navigator.pushNamed(context, '/dashboard');
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
