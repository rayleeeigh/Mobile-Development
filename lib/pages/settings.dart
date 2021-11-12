import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutterfire/functions/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("Settings"), backgroundColor: Colors.orange[400]),
      backgroundColor: Colors.grey[500],
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.orange[400],
              ),
              child: const Text(
                'Dashboard',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
                onTap: () {
                  Navigator.pushNamed(context, '/dashboard');
                },
                leading: GestureDetector(
                    child: const Icon(
                  Icons.home, // add custom icons also
                )),
                title: const Text("Home")),
            ListTile(
                onTap: () {
                  Navigator.pushNamed(context, '/profile');
                },
                leading: GestureDetector(
                    child: const Icon(
                  Icons.account_circle, // add custom icons also
                )),
                title: const Text("Profile")),
            ListTile(
                leading: GestureDetector(
                    child: const Icon(
                  Icons.settings, // add custom icons also
                )),
                title: const Text("Settings")),
          ],
        ),
      ),
      body: SingleChildScrollView(
          child: Column(children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: Column(
            children: [
              Container(
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    color: Colors.white),
                margin: const EdgeInsets.all(10.0),
                width: (MediaQuery.of(context).size.width),
                height: (MediaQuery.of(context).size.height) / 2,
              ),
              ElevatedButton(
                  style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0)),
                      minimumSize: const Size(250, 55),
                      maximumSize: const Size(600, 400),
                      textStyle: const TextStyle(fontSize: 20),
                      backgroundColor: Colors.orange[400]),
                  onPressed: () async {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    prefs.remove('email');
                    FirebaseService service = FirebaseService();
                    try {
                      await service.signOutFromGoogle();
                      Navigator.pushNamedAndRemoveUntil(
                          context, '/login', (route) => false);
                    } catch (e) {
                      if (e is FirebaseAuthException) {
                        print(e.message!);
                      }
                    }
                  },
                  child: const Text("Signout"))
            ],
          ),
        )
      ])),
    );
  }
}
