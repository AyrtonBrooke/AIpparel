import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<dynamic> cardData = [];

  @override
  void initState() {
    super.initState();
  }

  Future<void> loadCardData() async {
    String jsonCard = await rootBundle.loadString('assets/card.json');
    setState(() {
      cardData = jsonDecode(jsonCard);
    });
  }

  void _showCardDetails(String heading, String modalContent) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.brown[200],
          title: Text(
            heading,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.brown[600],
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Divider(color: Colors.brown[900]),
              SizedBox(height: 10),
              Text(
                modalContent,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.brown[700],
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                'Close',
                style: TextStyle(
                  color: Colors.yellowAccent,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget buildCard(dynamic card) {
    final String heading = card['heading'];
    final String paragraph = card['paragraph'];

    return GestureDetector(
      onTap: () {
        _showCardDetails(heading, card['modalContent']);
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 230,
          decoration: BoxDecoration(
            color: Colors.brown,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Stack(
            children: [
              Positioned(
                top: 10,
                left: 10,
                child: Card(
                  clipBehavior: Clip.antiAlias,
                  elevation: 10,
                  shadowColor: Colors.grey.shade400,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(35),
                  ),
                  child: Container(
                    height: 200,
                    width: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage(card['image']),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 20,
                left: 180,
                child: Container(
                  height: 200,
                  width: 200,
                  child: Column(
                    children: [
                      SizedBox(height: 10),
                      Text(
                        heading,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.brown[100],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Divider(color: Colors.white),
                      Text(
                        paragraph,
                        style: TextStyle(
                          fontSize: 14,
                          height: 1.4,
                          color: Colors.brown[100],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Divider(color: Colors.white),
                  Container(
                    alignment: Alignment.bottomCenter,
                    child: Text(
                      "Click for more info",
                      style: TextStyle(
                        fontSize: 14,
                        height: 1.4,
                        color: Colors.yellowAccent,
                        fontWeight: FontWeight.bold,
                      )),
                  ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[200],
      appBar: AppBar(
        title: const Text("Home"),
        automaticallyImplyLeading: false,
      ),
      body: ListView.builder(
        itemCount: cardData.length,
        itemBuilder: (context, index) {
          final card = cardData[index];
          return buildCard(card);
        },
      ),
    );
  }
}
