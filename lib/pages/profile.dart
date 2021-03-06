import 'package:flutter/material.dart';
import 'package:flutterfire/pages/dashboard.dart';
import 'package:flutterfire/pages/settings.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("Profile"), backgroundColor: Colors.orange[400]),
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
                leading: GestureDetector(
                    child: const Icon(
                  Icons.account_circle, // add custom icons also
                )),
                title: const Text("Profile")),
            ListTile(
                onTap: () {
                  Navigator.pushNamed(context, '/settings');
                },
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
            padding: const EdgeInsets.only(top: 0.0),
            child: Center(
                child: Image.network("https://i.ibb.co/zFpXYwL/pngwing-com.png",
                    height: 100, width: 100))),
        Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Container(
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  color: Colors.white),
              margin: const EdgeInsets.all(10.0),
              width: (MediaQuery.of(context).size.width),
              height: (MediaQuery.of(context).size.height) / 2,
            ))
      ])),
    );
  }
}
