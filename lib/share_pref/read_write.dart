import 'dart:html';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Share_pref extends StatefulWidget {
  const Share_pref({super.key});

  @override
  State<Share_pref> createState() => _Share_prefState();
}

class _Share_prefState extends State<Share_pref>{

  var nameconttroler=TextEditingController();
  SharedPreferences? prefs;

  @override
  void initState() {
    // TODO: implement initState
    getdata();
  }

  getdata()async{
    prefs=await SharedPreferences.getInstance();

    print(prefs?.getString('name'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('write read'),
      ),
      body: Container(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: nameconttroler,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10)
                  ),
                  label: Text('eneter text')
                ),
              ),
            ),
            SizedBox(height: 20,),
            
            ElevatedButton(onPressed: () async{
              // var name=nameconttroler.text.toString();


              prefs?.setString('name', nameconttroler.text.toString());
              // prefs?.remove('name');
              //prefs?.containsKey('name');

              print(prefs?.getString('name'));

            }, child: Text('click')),
            SizedBox(height: 20,),
            
            Text('Save value')
          ],
        ),
      )
    );
  }
}



