import 'package:flutter/material.dart';
import 'package:logger/logger.dart'; // Import the logger package

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Logger Demo',
      home: LoggerScreen(),
    );
  }
}

class LoggerScreen extends StatefulWidget {
  const LoggerScreen({super.key});

  @override
  State<LoggerScreen> createState() => _LoggerScreenState();
}

class _LoggerScreenState extends State<LoggerScreen> {
  final Logger _logger = Logger(); // Create a logger instance

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Logger Demo'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            _logger.t("Trace log");
            _logger.d("Debug log");
            _logger.i("Info log");
            _logger.w("Warning log");
            _logger.e("Error log", error: 'Test Error');
          },
          child: Text("Log Messages"),
        ),
      ),
    );
  }
}