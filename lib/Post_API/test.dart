import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp7());
}

class MyApp7 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: UserPage(),
    );
  }
}

class UserPage extends StatefulWidget {
  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();

  Future<void> deleteUser(int id) async {
    final url = Uri.parse('https://dummyjson.com/users/$id');
    final response = await http.delete(url);

    if (response.statusCode == 200) {
      print(response);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('User deleted successfully.$id')));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to delete user.')));
    }
  }

  Future<void> updateUser(int id, String firstName, String lastName, String age) async {
    final url = Uri.parse('https://dummyjson.com/users/$id');
    final response = await http.put(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'firstName': firstName,
        'lastName': lastName,
        'age': int.parse(age),
      }),
    );

    if (response.statusCode == 200) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('firstName', firstName);
      print('************************$firstName');

      prefs.setString('lastName', lastName);
      print('************************$lastName');

      prefs.setString('age', age);
      print('************************$age');


      print(response);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('User updated successfully.')));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to update user.')));
    }
  }

  @override
  void dispose() {
    _idController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _ageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Management'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: _idController,
                decoration: InputDecoration(labelText: 'User ID'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a user ID';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _firstNameController,
                decoration: InputDecoration(labelText: 'First Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a first name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _lastNameController,
                decoration: InputDecoration(labelText: 'Last Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a last name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _ageController,
                decoration: InputDecoration(labelText: 'Age'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an age';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    int id = int.parse(_idController.text);
                    deleteUser(id);
                  }
                },
                child: Text('Delete User'),
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    int id = int.parse(_idController.text);
                    String firstName = _firstNameController.text;
                    String lastName = _lastNameController.text;
                    String age = _ageController.text;
                    updateUser(id, firstName, lastName, age);
                  }
                },
                child: Text('Update User'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
