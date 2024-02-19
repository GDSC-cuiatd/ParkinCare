// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import 'package:myworking_app/Screens/Auth/login.dart';
import 'package:myworking_app/Screens/screens/TakeTest.dart';

class homepage extends StatefulWidget {
  const homepage({Key? key}) : super(key: key);

  @override
  State<homepage> createState() => _homebazaarState();
}

class _homebazaarState extends State<homepage> {
  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          actions: [
            // Add your actions here
            IconButton(
              icon: Icon(Icons.notification_add_sharp),
              onPressed: () {
                // Handle the search action
              },
            ),
          ],
          centerTitle: true,
          backgroundColor: Color(0xFF193660),
          title: Text(
            "ParkinCare",
            style: TextStyle(
              fontSize: 25,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          iconTheme: IconThemeData(color: Colors.white, size: 30),
        ),
        bottomNavigationBar: const GNav(
          gap: 4,
          backgroundColor: Color(0xFF193660),
          color: Colors.white,
          activeColor: Colors.white,
          tabs: [
            GButton(
              icon: Icons.home,
              text: "Home",
            ),
            GButton(
              icon: Icons.settings,
              text: "Settings",
            ),
            GButton(
              icon: Icons.person,
              text: "Profile",
            ),
            GButton(
              icon: Icons.help,
              text: "Help",
            ),
          ],
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Color(0xFF193660),
                ),
                child: Text(
                  'ParkinCare',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
              ListTile(
                title: Text('Item 1'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('Item 2'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(10, 25, 10, 10),
          child: Container(
            child: Column(
              children: [
                Card(
                  elevation: 5,
                  child: Container(
                    height: h * 0.20,
                    width: w,
                    decoration: BoxDecoration(
                      color: Color(0xFF193660),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Row(
                      children: [
                        Image.asset(
                          "lib/Assets/hand.png",
                          fit: BoxFit.contain,
                          height: h * 0.19,
                        ),
                        SizedBox(
                          width: h * 0.01,
                        ),
                        Text(
                          "Sketching a \nHealthier Future with \nParkinson's Care",
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: h * 0.03,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Card(
                      elevation: 5,
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Questionnaire(),
                            ),
                          );
                        },
                        child: Container(
                          height: h * 0.21,
                          width: w * 0.44,
                          decoration: BoxDecoration(
                            color: Color(0xFF193660),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                "lib/Assets/test.png",
                                height: 100,
                                width: 100,
                                fit: BoxFit.contain,
                              ),
                              SizedBox(height: 10),
                              Text(
                                "Take Test",
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Card(
                      elevation: 5,
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Questionnaire(),
                            ),
                          );
                        },
                        child: Container(
                          height: h * 0.21,
                          width: w * 0.44,
                          decoration: BoxDecoration(
                            color: Color(0xFF193660),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                "lib/Assets/food.png",
                                height: 100,
                                width: 100,
                                fit: BoxFit.contain,
                              ),
                              SizedBox(height: 10),
                              Text(
                                "Nutrition",
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: h * 0.015,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Card(
                      elevation: 5,
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginScreen(),
                            ),
                          );
                        },
                        child: Container(
                          height: h * 0.21,
                          width: w * 0.44,
                          decoration: BoxDecoration(
                            color: Color(0xFF193660),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                "lib/Assets/gymnastics.png",
                                height: 100,
                                width: 100,
                                fit: BoxFit.contain,
                              ),
                              SizedBox(height: 10),
                              Text(
                                "Therapy",
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Card(
                      elevation: 5,
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginScreen(),
                            ),
                          );
                        },
                        child: Container(
                          height: h * 0.21,
                          width: w * 0.44,
                          decoration: BoxDecoration(
                            color: Color(0xFF193660),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                "lib/Assets/report.png",
                                height: 100,
                                width: 100,
                                fit: BoxFit.contain,
                              ),
                              SizedBox(height: 10),
                              Text(
                                "Record",
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
