import 'package:flutter/material.dart';
import 'package:simple_ripple_animation/simple_ripple_animation.dart';

class Ripple extends StatefulWidget {
  const Ripple({super.key});

  @override
  State<Ripple> createState() => _RippleState();
}

class _RippleState extends State<Ripple> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shimmer'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Center(
        child: RippleAnimation(
          child: Icon(Icons.search_rounded),
          color: Colors.blue,
          delay: const Duration(milliseconds: 300),
          repeat: true,
          minRadius: 75,
          ripplesCount: 6,
          duration: const Duration(milliseconds: 6 * 300),
        ),
      ),
    );
  }
}
