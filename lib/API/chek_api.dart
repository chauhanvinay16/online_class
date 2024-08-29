import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PlaceholderApi extends StatefulWidget {
  const PlaceholderApi({super.key});

  @override
  State<PlaceholderApi> createState() => _PlaceholderApiState();
}

class _PlaceholderApiState extends State<PlaceholderApi> {
  List<dynamic>? doneDataList;

  Future<void> hitApi() async {
    try {
      final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));

      if (response.statusCode == 200) {
        setState(() {
          doneDataList = jsonDecode(response.body);
          print('***********API Hit**********\n $doneDataList');
        });
      } else {
        // Handle the error
        print('Failed to load data');
      }
    } catch (e) {
      // Handle any errors that occur during the HTTP request
      print('Error occurred: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    hitApi();  // Call the API when the widget initializes
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Placeholder API Data'),
      ),
      body: Center(
        child: doneDataList == null
            ? const CircularProgressIndicator()
            : ListView.builder(
          itemCount: doneDataList!.length,
          itemBuilder: (context, index) {
            return ListTile(
              leading: CircleAvatar(
                child: Text(doneDataList![index]['id'].toString()),
              ),
              title: Text(doneDataList![index]['title']),
              subtitle: Text(doneDataList![index]['body']),
            );
          },
        ),
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: PlaceholderApi(),
  ));
}
