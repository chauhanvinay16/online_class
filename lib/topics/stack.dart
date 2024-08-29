import 'package:flutter/material.dart';

class Stack_screen extends StatefulWidget {
  const Stack_screen({super.key});

  @override
  State<Stack_screen> createState() => _Stack_screenState();
}

class _Stack_screenState extends State<Stack_screen> {
  bool _isMoved=false;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Animated Stack Example')),
        body: Stack(
          children: <Widget>[
            Container(
              width: double.infinity,
              height: double.infinity,
              color: Colors.yellow,
            ),
            AnimatedPositioned(
              duration: Duration(seconds: 1),
              curve: Curves.easeInOut,
              left: 50,
              top: 100,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _isMoved = !_isMoved;
                  });
                },
                child: Container(
                  width: 100,
                  height: 100,
                  color: Colors.red,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
