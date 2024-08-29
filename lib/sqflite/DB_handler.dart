import 'dart:async';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

void main() => runApp(MyApp4());

class MyApp4 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo List',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TodoListScreen(),
    );
  }
}

class TodoListScreen extends StatefulWidget {
  @override
  _TodoListScreenState createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  late Future<Database> _database;
  final TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _openDatabase();
  }

  Future<void> _openDatabase() async {
    _database = openDatabase(
      join(await getDatabasesPath(), 'todo_database.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE todos(id INTEGER PRIMARY KEY AUTOINCREMENT, description TEXT)',
        );
      },
      version: 1,
    );
  }

  Future<void> _insertTodo(String description) async {
    final Database db = await _database;
    await db.insert(
      'todos',
      {'description': description},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Map<String, dynamic>>> _getTodos() async {
    final Database db = await _database;
    return db.query('todos');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo List'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _getTodos(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final todos = snapshot.data ?? [];
            return ListView.builder(
               itemCount: todos.length,
               itemBuilder: (context, index) {
                final todo = todos[index];
                return ListTile(
                  title: Text(todo['description']),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final String? newTodo = await showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Add Todo'),
              content: TextField(
                controller: _textEditingController,
                decoration: InputDecoration(hintText: 'Enter todo'),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('Cancel'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, _textEditingController.text.trim());
                  },
                  child: Text('Add'),
                ),
              ],
            ),
            
          );
          if (newTodo != null && newTodo.isNotEmpty) {
            await _insertTodo(newTodo);
            setState(() {}); // Refresh UI
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }
}
