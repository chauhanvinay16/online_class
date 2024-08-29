import 'package:flutter/material.dart';
import 'package:online_class/componat/color_helper.dart';
import 'package:online_class/share_pref/to_do/show_todo.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddNoteScreen extends StatefulWidget {
  const AddNoteScreen({super.key});

  @override
  State<AddNoteScreen> createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  final TextEditingController _title = TextEditingController();
  final TextEditingController _content = TextEditingController();

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();

  @override
  void dispose() {
    _title.dispose();
    _content.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add Note',
          style: TextStyle(
            fontFamily: 'Pacifico',
            fontSize: 20,
            color: whitecolor,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.deepPurple,
        leading: Icon(Icons.menu,color: whitecolor,),
        actions: [
          IconButton(
            icon: Icon(Icons.search,color: whitecolor,),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.more_vert,color: whitecolor,),
            onPressed: () {},
          ),
        ],
      ),
      body: RefreshIndicator(
        key: _refreshIndicatorKey,
        color: Colors.white,
        backgroundColor: Colors.blue,
        strokeWidth: 4.0,
        onRefresh: () async {
          // Replace this delay with the code to be executed during refresh
          // and return a Future when code finishes execution.
          return Future<void>.delayed(const Duration(seconds: 3));
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: _title,
                decoration: InputDecoration(
                  labelText: 'Title',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15)
                  ),
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: _content,
                maxLines: 5,
                decoration: InputDecoration(
                  labelText: 'Content',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15)
                  ),
                ),
              ),
              SizedBox(height: 16),
              SizedBox(
                height: 50,
                width: 330,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: lightcolor
                  ),
                  onPressed: () async{
                    final SharedPreferences prefs = await SharedPreferences.getInstance();

                    prefs.setString('title', _title.text);
                    print("Store Title:${_title.text}");
                    prefs.setString('content', _content.text);
                    print("Store Description:${_content.text}");

                    Navigator.push(context, MaterialPageRoute(builder: (context) => ShowTodoScreen(),));
                  },
                  child: Text('Add Note',style: TextStyle(color: whitecolor,fontSize: 15),),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}