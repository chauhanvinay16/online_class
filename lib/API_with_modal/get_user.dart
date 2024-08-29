import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:online_class/API_with_modal/api_services.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class DummyUseer extends StatefulWidget {
  const DummyUseer({super.key});

  @override
  State<DummyUseer> createState() => _DummyUseerState();
}

class _DummyUseerState extends State<DummyUseer> {

  bool isready=false;
  dynamic featchdata;
  dynamic uiuserupdate;


  _featchuserdata(){
    isready=true;
    Apiservices().getdummyuser().then((value) {
      setState(() {
        isready=false;
        featchdata=value;
        print('*************Response*****************\n $featchdata');
      });
    },).onError((error, stackTrace) {
      print(error);
    },);
  }


  @override
  void initState() {
    // TODO: implement initState
    _featchuserdata();
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


  final _formKey = GlobalKey<FormState>();
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Data'),
      ),
      body:isready==true ? Center(child: CircularProgressIndicator()):
      SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(featchdata['image'].toString()),
                    radius: 40,
                  ),
                  SizedBox(height: 16),
                  Text(
                    '${featchdata['firstName']} ${featchdata['lastName']}',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 8),
                  Text(
                    featchdata['email'].toString(),
                    style: TextStyle(color: Colors.grey),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 16),
                  Divider(thickness: 1),
                  SizedBox(height: 16),
                  DataTable(
                    columns: const <DataColumn>[
                      DataColumn(
                        label: Text('Field', style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      DataColumn(
                        label: Text('Value', style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                    ],
                    rows: <DataRow>[
                      DataRow(cells: [
                        DataCell(Text('First Name')),
                        DataCell(Text(featchdata['firstName'].toString())),
                      ]),
                      DataRow(cells: [
                        DataCell(Text('Last Name')),
                        DataCell(Text(featchdata['lastName'].toString())),
                      ]),
                      DataRow(cells: [
                        DataCell(Text('Maiden Name')),
                        DataCell(Text(featchdata['maidenName'].toString())),
                      ]),
                      DataRow(cells: [
                        DataCell(Text('Age')),
                        DataCell(Text(featchdata['age'].toString())),
                      ]),
                      DataRow(cells: [
                        DataCell(Text('Gender')),
                        DataCell(Text(featchdata['gender'].toString())),
                      ]),
                      DataRow(cells: [
                        DataCell(Text('Address')),
                        DataCell(Text(featchdata['address']['address'].toString())),
                      ]),
                      DataRow(cells: [
                        DataCell(Text('City')),
                        DataCell(Text(featchdata['address']['city'].toString())),
                      ]),
                      DataRow(cells: [
                        DataCell(Text('Latitude')),
                        DataCell(Text(featchdata['address']['coordinates']['lat'].toString())),
                      ]),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            ElevatedButton(onPressed: () {
                                  print('upadte');
                                  Alert(
                                      context: context,
                                      title: "Update Data",
                                      content: Column(
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
                                        ],
                                      ),
                                      buttons: [
                                        DialogButton(
                                          color: Colors.green,
                                          onPressed: () {
                                            print('update user chekk');
                                            if (_formKey.currentState!.validate()) {
                                              int id = int.parse(_idController.text);
                                              String firstName = _firstNameController.text;
                                              String lastName = _lastNameController.text;
                                              String age = _ageController.text;
                                              updateUser(id, firstName, lastName, age);
                                            }
                                          },
                                          child: Text(
                                            "Update user",
                                            style: TextStyle(color: Colors.white, fontSize: 16,fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ]).show();
                            },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green,
                                  foregroundColor: Colors.white
                                ),
                                child: Text('Update user')),
                            SizedBox(
                              width: 10,
                            ),
                            ElevatedButton(onPressed: () {
                                  print('delete');
                            }, style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                                foregroundColor: Colors.white
                            ),
                                child: Text('Delete user'))
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}



