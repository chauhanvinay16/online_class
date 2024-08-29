import 'dart:convert';

import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:online_class/Post_API/post_api_services.dart';

class Niraj_login extends StatefulWidget {
  const Niraj_login({super.key});

  @override
  State<Niraj_login> createState() => _Niraj_loginState();
}

class _Niraj_loginState extends State<Niraj_login> {
  TextEditingController username=TextEditingController();
  TextEditingController password=TextEditingController();
  bool isloading=false;
  dynamic logindata;


  _login(){
      isloading=true;
    post_api_services().nirajapi(username.text, password.text).then((value) {
        logindata=value;
        isloading=false;
        print("Respons==>${logindata}");
        jsonEncode("Response:${logindata}");
        AnimatedSnackBar.material(
          'User Login',
          type: AnimatedSnackBarType.success,
          mobileSnackBarPosition: MobileSnackBarPosition.bottom
        ).show(context);
    },).onError((error, stackTrace) {
      print("Error==>${error.toString()}");
    },);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center ,
          children: [
            TextField(
              controller: username,
              decoration: InputDecoration(
                hintText: 'Username'
              ),
            ),
            SizedBox(height: 20,),
            TextField(
              controller: password,
              decoration: InputDecoration(
                  hintText: 'Password'
              ),
            ),
            SizedBox(height: 50,),

            ElevatedButton(onPressed: () {
                    _login();
            },
                child: isloading==true ? Center(child: CircularProgressIndicator(),) :
                Text('Login'))
          ],
        ),
      ),
    );
  }
}
