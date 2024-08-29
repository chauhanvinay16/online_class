import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PRA extends StatefulWidget {
  const PRA({super.key});

  @override
  State<PRA> createState() => _PRAState();
}

class _PRAState extends State<PRA> {
  List<Map<String, dynamic>> donedata = [];

  Future<void> HitApi() async {
    http.Response response;
    response = await http.get(Uri.parse('https://reqres.in/api/users?page=2'));

    if (response.statusCode == 200) {
      setState(() {
        Map<String, dynamic> datamap = jsonDecode(response.body);
        donedata = List<Map<String, dynamic>>.from(datamap['data']);
        print('**********API HIT*************\n $donedata');
      });
    }
  }

  @override
  void initState() {
    super.initState();
    HitApi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PRACTIC'),
      ),
      body: Center(
        child: donedata.isEmpty
            ? CircularProgressIndicator()
            : Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView.builder(
            itemCount: donedata.length + 1, // Include header row
            itemBuilder: (context, index) {
              if (index == 0) {
                // Header row
                return Table(
                  border: TableBorder.all(),
                  children: [
                    TableRow(children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Email', style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('First Name', style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Last Name', style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Image', style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                    ]),
                  ],
                );
              } else {
                // Data rows
                final item = donedata[index - 1]; // Adjust index for header
                return Table(
                  border: TableBorder.all(),
                  children: [
                    TableRow(children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(item['email'] ?? ''),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(item['first_name'] ?? ''),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(item['last_name'] ?? ''),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: item['avatar'] != null
                            ? Image.network(
                          item['avatar'],
                          width: 50,
                          height: 50,
                        )
                            : Container(),
                      ),
                    ]),
                  ],
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
