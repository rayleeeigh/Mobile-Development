import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire/functions/database.dart';

import '../main.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        exit(0);
      },
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            iconTheme: const IconThemeData(color: Colors.black)),
        backgroundColor: Colors.white,
        drawer: Drawer(
          child: Container(
            color: Colors.grey[200],
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
                      color: Colors.black,
                      fontSize: 24,
                    ),
                  ),
                ),
                ListTile(
                    leading: GestureDetector(
                        child: const Icon(
                      Icons.home,
                      color: Colors.black, // add custom icons also
                    )),
                    title: const Text("Home")),
                ListTile(
                    onTap: () {
                      Navigator.pushNamed(context, '/profile');
                    },
                    leading: GestureDetector(
                        child: const Icon(
                      Icons.account_circle,
                      color: Colors.black, // add custom icons also
                    )),
                    title: const Text("Profile")),
                ListTile(
                    onTap: () {
                      Navigator.pushNamed(context, '/settings');
                    },
                    leading: GestureDetector(
                        child: const Icon(
                      Icons.settings,
                      color: Colors.black, // add custom icons also
                    )),
                    title: const Text("Settings")),
              ],
            ),
          ),
        ),
        body: SingleChildScrollView(
            child: Column(children: <Widget>[
          Container(
              padding:
                  const EdgeInsets.only(top: 96.0, left: 38.0, right: 38.0),
              color: Colors.orange[400],
              width: (MediaQuery.of(context).size.width),
              height: (MediaQuery.of(context).size.height) / 2,
              child: Column(
                children: [
                  const Text(
                    "We move and pack, aiming to have an impact",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 32),
                  ),
                  Image.network(
                      "https://i.ibb.co/25xzGWV/undraw-deliveries-131a.png",
                      height: 200,
                      width: 240)
                ],
              )),
          Container(
            margin: const EdgeInsets.only(top: 40.0),
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Container(
                    decoration: const BoxDecoration(color: Colors.transparent),
                    margin: const EdgeInsets.all(10.0),
                    width: (MediaQuery.of(context).size.width),
                    height: (MediaQuery.of(context).size.height) / 2,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                  width:
                                      (MediaQuery.of(context).size.width / 2 -
                                          50),
                                  height:
                                      (MediaQuery.of(context).size.height / 4 -
                                          50),
                                  decoration: BoxDecoration(
                                      color: Colors.orange[100],
                                      border: Border.all(color: Colors.black)),
                                  child: const Center(
                                    child: Text(
                                      "Create",
                                      textAlign: TextAlign.center,
                                    ),
                                  )),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                  width:
                                      (MediaQuery.of(context).size.width / 2 -
                                          50),
                                  height:
                                      (MediaQuery.of(context).size.height / 4 -
                                          50),
                                  decoration: BoxDecoration(
                                      color: Colors.orange[100],
                                      border: Border.all(color: Colors.black)),
                                  child: const Center(
                                    child: Text(
                                      "Update",
                                      textAlign: TextAlign.center,
                                    ),
                                  )),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                  width:
                                      (MediaQuery.of(context).size.width / 2 -
                                          50),
                                  height:
                                      (MediaQuery.of(context).size.height / 4 -
                                          50),
                                  decoration: BoxDecoration(
                                      color: Colors.orange[100],
                                      border: Border.all(color: Colors.black)),
                                  child: const Center(
                                    child: Text(
                                      "Delete",
                                      textAlign: TextAlign.center,
                                    ),
                                  )),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                  width:
                                      (MediaQuery.of(context).size.width / 2 -
                                          50),
                                  height:
                                      (MediaQuery.of(context).size.height / 4 -
                                          50),
                                  decoration: BoxDecoration(
                                      color: Colors.orange[100],
                                      border: Border.all(color: Colors.black)),
                                  child: const Center(
                                    child: Text(
                                      "Leave",
                                      textAlign: TextAlign.center,
                                    ),
                                  )),
                            )
                          ],
                        )
                      ],
                    ))),
          )
        ])),
      ),
    );
  }
}
