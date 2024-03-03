import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:aiapparel/auth/login.dart';

class OutfitsPage extends StatefulWidget {
  const  OutfitsPage({Key? key}) : super(key: key);
  @override
  _OutfitsState createState() => _OutfitsState();
}


class _OutfitsState extends State<OutfitsPage> {
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
        title: const Text("Outfits"),
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