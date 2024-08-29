import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(arc());
}

class arc extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shared Preferences Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late SharedPreferences _prefs;
  String _username = '';

  @override
  void initState() {
    super.initState();
    _initSharedPreferences();
  }

  void _initSharedPreferences() async {
    _prefs = await SharedPreferences.getInstance();
    _loadUsername();
  }

  void _loadUsername() {
    setState(() {
      _username = _prefs.getString('username') ?? 'no value';
    });
  }

  void _saveUsername(String newUsername) {
    _prefs.setString('username', newUsername);
    setState(() {
      _username = newUsername;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shared Preferences Demo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Username:',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 10),
            Text(
              _username,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
           ElevatedButton(onPressed: () async{
             String newUsername = await _showInputDialog(context);
             if (newUsername != null && newUsername.isNotEmpty) {
               _saveUsername(newUsername);
             }
           }, child: Text('change user name'))
          ],
        ),
      ),
    );
  }

  Future _showInputDialog(BuildContext context) {
    TextEditingController _textFieldController = TextEditingController();

    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Enter New Username'),
          content: TextField(
            controller: _textFieldController,
            decoration: InputDecoration(hintText: "Username"),
          ),
          actions: <Widget>[
            ElevatedButton(onPressed: () {
              Navigator.pop(context);
            }, child: Text('cancle')),
            ElevatedButton(onPressed: () {
              Navigator.pop(context, _textFieldController.text);
            }, child: Text('Save'))
          ],
        );
      },
    );
  }
}
