import 'package:flutter/material.dart';
import 'package:online_class/API_with_modal/api_services.dart';
import 'package:online_class/List_API/api_servicess.dart';
import 'package:intl/intl_standalone.dart';
import 'list_modal.dart';

class Screenwithmodal extends StatefulWidget {
  const Screenwithmodal({super.key});

  @override
  State<Screenwithmodal> createState() => _ScreenwithmodalState();
}

class _ScreenwithmodalState extends State<Screenwithmodal> {

  bool isreddy =false;
  List<PostModal> postmodal=[];

  _getpost(){
    isreddy=true;
    ApiServicess().getpostmodal().then((value) {
      setState(() {
        isreddy=false;
        postmodal=value!;
        print('**************API HIT***********\n $postmodal');
      });
    },).onError((error, stackTrace) {
      print(error);
    },);
  }

  @override
  void initState() {
    // TODO: implement initState
    _getpost();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List With Modal'),
      ),
      body:isreddy==true ? CircularProgressIndicator():
      ListView.builder(
          itemCount: postmodal.length,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                leading: Text(postmodal[index].id.toString()),
                title: Text(postmodal[index].title.toString()),
                subtitle: Text(postmodal[index].title.toString()),
              ),
            );
          },
      ),
    );
  }
}
