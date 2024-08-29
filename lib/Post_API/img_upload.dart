import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Image Upload Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ImageUploadPage(),
    );
  }
}

class ImageUploadPage extends StatefulWidget {
  @override
  _ImageUploadPageState createState() => _ImageUploadPageState();
}

class _ImageUploadPageState extends State<ImageUploadPage> {
  File? _image;

  Future<File?> pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      return File(pickedFile.path);
    }
    return null;
  }

  Future<void> uploadImage(File image) async {
    var request = http.MultipartRequest(
      'POST',
      Uri.parse('https://api.escuelajs.co/api/v1/files/upload'), // Replace with your API endpoint
    );
    request.files.add(await http.MultipartFile.fromPath('file', image.path));

    var response = await request.send();

    if (response.statusCode == 201) {
      print('Image uploaded successfully!$response');
    } else {
      print('Image upload failed with status: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Upload Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _image != null
                ? Image.file(_image!)
                : Text('No image selected.'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final pickedImage = await pickImage();
                if (pickedImage != null) {
                  setState(() {
                    _image = pickedImage;
                  });
                }
              },
              child: Text('Pick Image'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _image != null
                  ? () async {
                AnimatedSnackBar.material(
                  'Image uploaded successfully!',
                  type: AnimatedSnackBarType.success,
                  mobileSnackBarPosition: MobileSnackBarPosition.bottom,
                ).show(context);
                await uploadImage(_image!);
              }
                  : null,
              child: Text('Upload Image'),
            ),
          ],
        ),
      ),
    );
  }
}
