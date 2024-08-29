import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SeeJobScreen extends StatefulWidget {

  final String? id,name,job;
  const SeeJobScreen({super.key, this.id, this.name, this.job});

  @override
  State<SeeJobScreen> createState() => _SeeJobScreenState();
}

class _SeeJobScreenState extends State<SeeJobScreen> {

  String? id;
  String? name;
  String? job;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      id = prefs.getString('id');
      print(id);
      name = prefs.getString('name');
      print(name);
      job = prefs.getString('job');
      print(job);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('See Data'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
        DataTable(
        columns: [
          DataColumn(label: Text('ID')),
          DataColumn(label: Text('Name')),
          DataColumn(label: Text('Job')),
        ],
        rows: [
        DataRow(cells: [
          DataCell(Text(id ?? 'N/A')),
          DataCell(Text(name ?? 'N/A')),
          DataCell(Text(job ?? 'N/A')),
        ]),
        ],),
          ],
        ),
      ),
    );
  }
}
