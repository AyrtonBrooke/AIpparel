import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:aiapparel/auth/login.dart';

class WardrobePage extends StatefulWidget {
  const  WardrobePage({Key? key}) : super(key: key);
  @override
  _WardrobeState createState() => _WardrobeState();
}

class _WardrobeState extends State<WardrobePage> {

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isMobile = screenWidth < 600;
    return Scaffold(
      backgroundColor: Colors.brown[200],
      appBar: AppBar(
        title: const Text("Wardrobe"),
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: Container(
        height: screenHeight,
        width: screenWidth,
        padding: const EdgeInsets.all(10),
        child: ListView(
        ),
      ),
    );
  }
}