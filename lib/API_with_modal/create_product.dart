import 'package:flutter/material.dart';

import 'api_services.dart';

void main() {
  runApp(MyApp6());
}

class MyApp6 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Create Product'),
        ),
        body: CreateProductForm(),
      ),
    );
  }
}

class CreateProductForm extends StatefulWidget {
  @override
  _CreateProductFormState createState() => _CreateProductFormState();
}

class _CreateProductFormState extends State<CreateProductForm> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _categoryIdController = TextEditingController();
  final TextEditingController _imagesController = TextEditingController();

  final Apiservices _apiService = Apiservices();

  void _createProduct() {
    final String title = _titleController.text;
    final double price = double.parse(_priceController.text);
    final String description = _descriptionController.text;
    final int categoryId = int.parse(_categoryIdController.text);
    final List<String> images = _imagesController.text.split(',');

    _apiService.createProduct(title, price, description, categoryId, images);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextField(
            controller: _titleController,
            decoration: InputDecoration(labelText: 'Title'),
          ),
          TextField(
            controller: _priceController,
            decoration: InputDecoration(labelText: 'Price'),
            keyboardType: TextInputType.number,
          ),
          TextField(
            controller: _descriptionController,
            decoration: InputDecoration(labelText: 'Description'),
          ),
          TextField(
            controller: _categoryIdController,
            decoration: InputDecoration(labelText: 'Category ID'),
            keyboardType: TextInputType.number,
          ),
          TextField(
            controller: _imagesController,
            decoration: InputDecoration(labelText: 'Images (comma separated URLs)'),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed:() {
              _createProduct();
            },
            child: Text('Create Product'),
          ),
        ],
      ),
    );
  }
}
