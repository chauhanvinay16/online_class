import 'package:flutter/material.dart';
import 'package:online_class/List_API/api_servicess.dart';

import 'movimodal.dart';

class MoviApi extends StatefulWidget {
  const MoviApi({super.key});

  @override
  State<MoviApi> createState() => _MoviApiState();
}

class _MoviApiState extends State<MoviApi> {

  bool isready=false;
  List<movimodal> movimod=[];

  _moviresivedata(){
    isready=true;
    ApiServicess().getmovimodaldata().then((value) {
      setState(() {
        isready=false;
        movimod=value!;
        print('****************API HIT*************$movimod');
      });
    },).onError((error, stackTrace) {
      print(error);
    },);
  }

  @override
  void initState() {
    // TODO: implement initState
    _moviresivedata();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
          title: Text('Movi Data'),
       ),
      body: isready==true ? Container(child: CircularProgressIndicator()):
      ListView.builder(
        itemCount: movimod.length,
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.all(10.0),
            elevation: 5.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movimod[index].id.toString(),
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[700],
                    ),
                  ),
                  SizedBox(height: 5.0),
                  Text(
                    movimod[index].title.toString(),
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 5.0),
                  Text(
                    'by ${movimod[index].author}',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontStyle: FontStyle.italic,
                      color: Colors.grey[600],
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    'Published on ${movimod[index].datePublished}',
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.grey[600],
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Card(
                    color: Colors.blue[50],
                    elevation: 3.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Text(
                        movimod[index].content.toString(),
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
      },)
    );
  }
}
