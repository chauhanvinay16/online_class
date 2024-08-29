import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../componat/color_helper.dart';

class ShowTodoScreen extends StatefulWidget {
  const ShowTodoScreen({super.key});

  @override
  State<ShowTodoScreen> createState() => _ShowTodoScreenState();
}

class _ShowTodoScreenState extends State<ShowTodoScreen> {
  String _title = "";
  String _content = "";

  Future<void> _getdata() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _title = prefs.getString("title") ?? "";
      _content = prefs.getString("content") ?? "";
    });
  }

  @override
  void initState() {
    super.initState();
    _getdata();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'View Data',
          style: TextStyle(
            fontFamily: 'Pacifico',
            fontSize: 20,
            color: whitecolor,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.deepPurple,
        leading: BackButton(color: whitecolor,),
        actions: [
          IconButton(
            icon: Icon(Icons.favorite_border,color: whitecolor,),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Card(
            elevation: 5,
            color: HexColor('#F6F5F5'),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    _content,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          // Update note logic here
                        },
                      ),
                      SizedBox(width: 8),
                      IconButton(
                        icon: Icon(Icons.delete),
                        color: Colors.red,
                        onPressed: () async{
                          final SharedPreferences prefs = await SharedPreferences.getInstance();
                          await prefs.remove('title');
                          await prefs.remove('content');
                          setState(() {
                            _title = "";
                            _content = "";
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}