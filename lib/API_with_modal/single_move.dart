import 'package:flutter/material.dart';
import 'package:online_class/API_with_modal/api_services.dart';


class MovieData extends StatefulWidget {
  const MovieData({super.key});

  @override
  State<MovieData> createState() => _MovieDataState();
}

class _MovieDataState extends State<MovieData> {
  dynamic movidata;
  bool isreddy=true;

  _getmoviedata(){
    isreddy=true;
    Apiservices().getmovidata().then((value) {
      setState(() {
        movidata=value;
        isreddy=false;
        print('********Movie API HIT************\n $movidata');
      });
    },).onError((error, stackTrace) {
      print(error);
    },);
  }

  @override
  void initState() {
    // TODO: implement initState
    _getmoviedata();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Movie Data'),
          centerTitle: true,
          backgroundColor: Colors.indigo[200],
        ),
      body:isreddy==true ? Center(child: CircularProgressIndicator()):
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Table(
            border: TableBorder.all(),
            children: [
              TableRow(
                children: [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Movie'),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(movidata['movie'].toString()),
                  ),
                ],
              ),
              TableRow(
                children: [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Ratting'),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(movidata['rating'].toString())
                  ),
                ],
              ),
              TableRow(
                children: [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Image'),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(movidata['image'].toString())
                  ),
                ],
              ),
            ],
          ),
        ],
      )
    );
  }
}
