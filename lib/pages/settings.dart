import 'package:flutter/material.dart';
import 'package:flutterfire/pages/dashboard.dart';
import 'package:flutterfire/pages/profile.dart';
import 'package:flutterfire/main.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
                  Navigator.push(
                      context,
                      PageRouteBuilder(
                          transitionDuration: const Duration(seconds: 1),
                          transitionsBuilder:
                              (context, animation, secondaryAnimation, child) {
                            const begin = Offset(2.0, 0.0);
                            const end = Offset.zero;
                            const curve = Curves.ease;

                            final tween = Tween(begin: begin, end: end);
                            final curvedAnimation = CurvedAnimation(
                              parent: animation,
                              curve: curve,
                            );

                            return SlideTransition(
                              position: tween.animate(curvedAnimation),
                              child: child,
                            );
                          },
                          pageBuilder: (context, animation, animationTime) {
                            return const DashboardPage();
                          }));
                },
                leading: GestureDetector(
                    child: const Icon(
                  Icons.home, // add custom icons also
                )),
                title: const Text("Home")),
            ListTile(
                onTap: () {
                  Navigator.push(
                      context,
                      PageRouteBuilder(
                          transitionDuration: const Duration(seconds: 1),
                          transitionsBuilder:
                              (context, animation, secondaryAnimation, child) {
                            const begin = Offset(2.0, 0.0);
                            const end = Offset.zero;
                            const curve = Curves.ease;

                            final tween = Tween(begin: begin, end: end);
                            final curvedAnimation = CurvedAnimation(
                              parent: animation,
                              curve: curve,
                            );

                            return SlideTransition(
                              position: tween.animate(curvedAnimation),
                              child: child,
                            );
                          },
                          pageBuilder: (context, animation, animationTime) {
                            return const ProfilePage();
                          }));
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
                    await FirebaseAuth.instance.signOut();
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => App()));
                  },
                  child: const Text("Signout"))
            ],
          ),
        )
      ])),
    );
  }
}
