import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:aiapparel/auth/login.dart';

class SettingsPage extends StatefulWidget {
  const  SettingsPage({Key? key}) : super(key: key);
  @override
  _SettingsState createState() => _SettingsState();
}

signUserOut(BuildContext context) async {
  FirebaseAuth.instance.signOut();
}

class _SettingsState extends State<SettingsPage> {
  bool valNotify1 = true;
  bool valNotify2 = true;
  bool valNotify3 = false;

  onChangeFunction1(bool newValue1) {
    setState(() {
      valNotify1 = newValue1;
    });
  }

  onChangeFunction2(bool newValue2) {
    setState(() {
      valNotify2 = newValue2;
    });
  }

  onChangeFunction3(bool newValue3) {
    setState(() {
      valNotify3 = newValue3;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isMobile = screenWidth < 600;
    return Scaffold(
      backgroundColor: Colors.brown[200],
      appBar: AppBar(
        title: const Text("Settings"),
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: Container(
        height: screenHeight,
        width: screenWidth,
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [
            Row(
              children: [
                Icon(Icons.person, color: Colors.brown),
                SizedBox(width: 10),
                Text("User", style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold
                ))
              ],
            ),
            Divider(height: 20, thickness: 1),
            ListTile(
              title: Text('My Account', style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w500
              )),
              trailing: Icon(Icons.keyboard_arrow_right_sharp),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Icon(Icons.notifications, color: Colors.brown),
                SizedBox(width: 10),
                Text("Notifications", style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold
                ))
              ],
            ),
            Divider(height: 20, thickness: 1),
            buildNotificationOption(
                "Email Notifications", valNotify1, onChangeFunction1),
            buildNotificationOption(
                "Push Notifications", valNotify2, onChangeFunction2),
            Row(
              children: [
                Icon(Icons.format_color_fill, color: Colors.brown),
                SizedBox(width: 10),
                Text("Appearance", style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold
                ))
              ],
            ),
            Divider(height: 20, thickness: 1),
            ListTile(
              title: Text('Languages', style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w500
              )),
              trailing: Icon(Icons.keyboard_arrow_right_sharp),
            ),
            buildNotificationOption("Dark Mode", valNotify3, onChangeFunction3),
            SizedBox(height: 10),
            Center(
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                    backgroundColor: Colors.brown,
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)
                    )
                ),
                onPressed: () {
                  FirebaseAuth.instance.signOut().then((value) {
                    print("Signed out");
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Login()));
                  });
                },
                child: Text("Log Out", style: TextStyle(
                    fontSize: 16, letterSpacing: 2.2, color: Colors.white
                )),
              ),
            ),
            Center(
              child: Text("Version 1.0.1", style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold
              )),
            )
          ],
        ),
      ),
    );
  }

  Padding buildNotificationOption(String title, bool value,
      Function onChangeMethod) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w500,
              color: Colors.black
          )),
          Transform.scale(
              scale: 0.7,
              child: CupertinoSwitch(
                  activeColor: Colors.lightGreenAccent,
                  trackColor: Colors.black,
                  value: value,
                  onChanged: (bool newValue) {
                    onChangeMethod(newValue);
                  }
              )
          )
        ],
      ),
    );
  }
}