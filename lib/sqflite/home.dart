import 'dart:async';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

void main() => runApp(MyApp3());

class MyApp3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sqflite CRUD Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SqfliteDemo(),
    );
  }
}

class SqfliteDemo extends StatefulWidget {
  @override
  _SqfliteDemoState createState() => _SqfliteDemoState();
}

class _SqfliteDemoState extends State<SqfliteDemo> {
  late Database _database;

  @override
  void initState() {
    super.initState();
    _initDatabase();
  }

  Future<void> _initDatabase() async {
    _database = await openDatabase(
      join(await getDatabasesPath(), 'demo_database.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE demo(id INTEGER PRIMARY KEY, name TEXT, age INTEGER)',
        );
      },
      version: 1,
    );
  }

  Future<void> _insertData() async {
    await _database.insert(
      'demo',
      {'name': 'John', 'age': 30},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    print('Data inserted successfully.');
  }

  Future<void> _updateData() async {
    await _database.update(
      'demo',
      {'age': 35},
      where: 'name = ?',
      whereArgs: ['John'],
    );
    print('Data updated successfully.');
  }

  Future<List<Map<String, dynamic>>> _readData() async {
    return await _database.query('demo');
  }

  Future<void> _deleteData() async {
    await _database.delete(
      'demo',
      where: 'name = ?',
      whereArgs: ['John'],
    );
    print('Data deleted successfully.');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sqflite CRUD Demo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () async {
                await _insertData();
              },
              child: Text('Insert Data'),
            ),
            ElevatedButton(
              onPressed: () async {
                await _updateData();
              },
              child: Text('Update Data'),
            ),
            ElevatedButton(
              onPressed: () async {
                List<Map<String, dynamic>> data = await _readData();
                print(data);
              },
              child: Text('Read Data'),
            ),
            ElevatedButton(
              onPressed: () async {
                await _deleteData();
              },
              child: Text('Delete Data'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _database.close();
    super.dispose();
  }
}


// import 'package:flutter/material.dart';
// import 'package:online_class/sqflite/DB_handler.dart';
//
// class SQL extends StatefulWidget {
//   const SQL({super.key});
//
//   @override
//   State<SQL> createState() => _SQLState();
// }
//
// class _SQLState extends State<SQL> {
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           ElevatedButton(onPressed: () async{
//             await DbHandler().insertData();
//           }, child: Text('insert')),
//         ],
//       ),
//     );
//   }
// }
