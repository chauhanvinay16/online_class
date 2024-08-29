import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class Smimmerscreen extends StatefulWidget {
  const Smimmerscreen({super.key});

  @override
  State<Smimmerscreen> createState() => _SmimmerscreenState();
}

class _SmimmerscreenState extends State<Smimmerscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shimmer'),
        backgroundColor: Colors.deepPurple,
      ),
      body: ListView.builder(
          itemCount: 7,
          itemBuilder: (context, index) {
            return SizedBox(
              height: 150.0,
              child: SizedBox(
                width: 200.0,
                height: 100.0,
                child: Shimmer.fromColors(
                  baseColor: Colors.grey,
                  highlightColor: Colors.white,
                  child: Container(
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey, width: 1.0), // Add this line
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            );
          },
      ),
    );
  }
}
