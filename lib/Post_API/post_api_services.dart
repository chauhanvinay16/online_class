import 'dart:convert';


import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login_modal.dart';
import 'package:http/http.dart' as http;

class post_api_services{

  Future<loginmodal?>loginmodaldata(String email,String password) async{
    try{
      // var uri=Uri.parse('https://reqres.in/api/login');
      // var response=await http.post(uri,body: {
      //   "email": email,
      //   "password": password,
      // });
      var response=await http.post(Uri.parse('https://reqres.in/api/login'),body: {
        "email": email,
        "password": password
      });
      if(response.statusCode==200){
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('email', email);
        print('***************************$email');
        await prefs.setString('password', password);
        print('***************************$password');


        loginmodal modal= loginmodal.fromJson(jsonDecode(response.body));
        return modal;
      }
    }catch(e){
      print(e);
    }
  }
  
  Future<dynamic>Registretion(String email,String password)async{
    try{
      var response=await http.post(Uri.parse('https://reqres.in/api/register'),body: {
        "email": email,
        "password": password
      });
      if(response.statusCode==200){
        final register=jsonDecode(response.body);
        return register;
      }
    }catch(e){
      print(e);
    }
  }

  Future<dynamic>plazilogin(String email,String password) async{
    SharedPreferences preferences=await SharedPreferences.getInstance();
    preferences.setString('email', email);
    print('Local Storage email: ${email}');
    preferences.setString('email', email);
    print("Local Storage Password: ${jsonEncode(password)}");
    try{
      var response= await http.post(Uri.parse('https://api.escuelajs.co/api/v1/auth/login'),
      body: {
          "email": email,
          "password": password
          },
      );
      if(response.statusCode==201){
        final plzlogin=jsonDecode(response.body);
        return plzlogin;
      }
    }catch(e){
      debugPrint("Error here => ${e.toString()}");
    }
  }

  Future<dynamic>nirajapi(String username,String password)async{
    try{
        var response= await http.post(Uri.parse('https://dummyjson.com/auth/login'),
          body: {
              "username": username,
              "password": password,
          },
        );
        if(response.statusCode==200){
            final data=jsonDecode(response.body);
            return data;
        }
    }catch(e){
      print("Error: ${e.toString()}");
    }
  }
}