import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Hit_api extends StatefulWidget {
  const Hit_api({super.key});

  @override
  State<Hit_api> createState() => _Hit_apiState();
}

class _Hit_apiState extends State<Hit_api> {
  Map<String,dynamic>?datamap;
  Map<String,dynamic>?Donrdatamap;
  // Map<String,dynamic>?suppoer;

  List<dynamic>?Donedatalist;

  Future hitApi() async{
    http.Response response;
    response=await http.get(Uri.parse('https://reqres.in/api/users?page=2'));

    if(response.statusCode==200){
      setState(() {
            datamap=jsonDecode(response.body);
            Donedatalist=datamap!['data'];
            // suppoer=datamap!['support'];
            print('***********Api Hit-1**********\n $Donedatalist');
            // print('***********Respons2**********\n $suppoer');
      });
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    hitApi();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Get API'),
      ),
      body: Center(
        child:Donedatalist==null ? CircularProgressIndicator():
        ListView.builder(
            itemCount: Donedatalist!.length,
            itemBuilder:(context, index) {
              return ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(Donedatalist![index]['avatar'].toString())
                ),
                title: Text(Donedatalist![index]['first_name'].toString() +  Donedatalist![index]['last_name']),
                subtitle: Text(Donedatalist![index]['email'].toString()),
              );
            },
        ),
      )
    );
  }
}
