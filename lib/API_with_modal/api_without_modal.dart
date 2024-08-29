import 'package:flutter/material.dart';
import 'package:online_class/API_with_modal/api_services.dart';

class Screeenwithoutmodal extends StatefulWidget {
  const Screeenwithoutmodal({super.key});

  @override
  State<Screeenwithoutmodal> createState() => _ScreeenwithoutmodalState();
}

class _ScreeenwithoutmodalState extends State<Screeenwithoutmodal> {

  dynamic singlePost;
  bool isReady=false;

  _getsinglePostwithoutmodal(){
    isReady=true;
    Apiservices().getsinglePostwithoutModal().then((value) {
      setState(() {
        singlePost=value;
        isReady=false;
        print('*************API HIT**************\n $singlePost');
      });
    },).onError((error, stackTrace) {
      print(error);
      isReady=false;
    }, );
  }

  @override
  void initState() {
    // TODO: implement initState
    _getsinglePostwithoutmodal();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Without modal'),
      ),
      body: isReady==true ? Center(child: CircularProgressIndicator()):
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(singlePost['userId'].toString()),
            Text(singlePost['title'].toString()),
            Text(singlePost['body'].toString()),
          ],
      ),
    );
  }
}
