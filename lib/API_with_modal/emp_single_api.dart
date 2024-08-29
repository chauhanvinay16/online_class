import 'package:flutter/material.dart';
import 'package:online_class/API_with_modal/api_services.dart';

import 'api_services.dart';

class EMP extends StatefulWidget {
  const EMP({super.key});

  @override
  State<EMP> createState() => _EMPState();
}

class _EMPState extends State<EMP> {
  
  dynamic emppost;
  bool isreddy=false;
  
  _getempdata(){
    isreddy=true;
    Apiservices().getempdata().then((value) {
      setState(() {
        isreddy=false;
        emppost=value;
        print("**************API HIT************\n $emppost");
      });
    },).onError((error, stackTrace) {
      print(error);
    },);
  }
  
  @override
  void initState() {
    // TODO: implement initState
    _getempdata();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('EMP Data'),
      ),
      body: isreddy==true ? Center(child: CircularProgressIndicator()):
      Table(
        border: TableBorder.all(),
        children: [
          TableRow(
            children: [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Employee Name'),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(emppost!['data']['employee_name'].toString()),
              ),
            ],
          ),
          TableRow(
            children: [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Employee Salary'),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(emppost!['data']['employee_salary'].toString()),
              ),
            ],
          ),
          TableRow(
            children: [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Employee Age'),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(emppost!['data']['employee_age'].toString()),
              ),
            ],
          ),
        ],
      )
    );
  }
}



