import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(TestLayout());
}

class TestLayout extends StatefulWidget {
  const TestLayout({super.key});

  @override
  State<TestLayout> createState() => _TestLayoutState();
}

class _TestLayoutState extends State<TestLayout> {
  @override
  Widget build(BuildContext context) {
    List<String> teclas = ["Q", "W", "E", "R", "T", "Y", "U", "I", "O"];
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "WORDLE (ES)",
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
          shape: Border(bottom: BorderSide(color: Colors.grey)),
        ),

        body: Column(
          children: [
            Center(
              child: Expanded(
                flex: 2,
                child: Container(
                  margin: EdgeInsets.all(20),
                  child: GridView.count(
                    crossAxisCount: 5,
                    crossAxisSpacing: 4,
                    mainAxisSpacing: 4,

                    children: List.generate(
                      30,
                      (index) => Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey, width: 2),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),

            Expanded(child: Column(children: [Row(children: [],), Row(), Row()])),
          ],
        ),
      ),
    );
  }
}
