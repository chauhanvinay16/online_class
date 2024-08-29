import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:online_class/List_API/quets.dart';
import 'package:online_class/Post_API/login_modal.dart';
import 'package:online_class/Post_API/post_api_services.dart';
import 'package:online_class/create_post_API/api_services_post.dart';
import 'package:online_class/create_post_API/modal.dart';
import 'package:online_class/create_post_API/see_job.dart';
import 'package:shared_preferences/shared_preferences.dart';


class jobscreen extends StatefulWidget {
  const jobscreen({super.key});

  @override
  State<jobscreen> createState() => _LoginpostState();
}

class _LoginpostState extends State<jobscreen> {

  TextEditingController name=TextEditingController();
  TextEditingController job=TextEditingController();

  Future<void> _saveData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('name', name.text);
    await prefs.setString('job', job.text);

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Data Saved!')));
  }


  Postmodal postmodal=Postmodal();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: postmodal.name==null || postmodal.name==" "?
            Text("Create a job"):Text('Create a Job ${postmodal.name}'),
      ),
      body:  Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Create Job',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueAccent,
                      ),
                    ),
                    SizedBox(height: 20),
                    TextField(
                      controller: name,
                      decoration: InputDecoration(
                        labelText: 'Enter Name',
                        prefixIcon: Icon(Icons.email),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    TextField(
                      controller: job,
                      decoration: InputDecoration(
                        labelText: 'Enter Job',
                        prefixIcon: Icon(Icons.lock),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
                    ElevatedButton(
                      onPressed: () {
                          Apiservicescreate().createjob(name.text.toString(), job.text.toString()).then((value) {
                            setState(() {
                              postmodal=value!;
                              _saveData();
                              print(value);
                              Navigator.push(context, MaterialPageRoute(builder: (context) => SeeJobScreen(
                                id: postmodal.id.toString(),
                                name: postmodal.name.toString(),
                                job: postmodal.job.toString(),
                              ),));
                            });
                          },).onError((error, stackTrace) {
                            print(error);
                          },);
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 30.0),
                        child: Text('Create Job', style: TextStyle(fontSize: 18,color: Colors.white)),
                      ),
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ), backgroundColor: Colors.blueAccent,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}



