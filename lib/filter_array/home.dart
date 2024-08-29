import 'package:flutter/material.dart';
import 'package:online_class/filter_array/api_services.dart';

import 'modal.dart';


class Fillterscreen extends StatefulWidget {
  const Fillterscreen({super.key});

  @override
  State<Fillterscreen> createState() => _FillterscreenState();
}

class _FillterscreenState extends State<Fillterscreen> {
  bool issloading=false;
  getUswerlist(){
    setState(() {
      issloading=true;
    });
    APISERVICESAR().userlistdata().then((value) {
      _formale(value!.users!);
      _forfemale(value!.users!);
      setState(() {
        issloading=false;
        print(value);
      });
    },).onError((error, stackTrace) {
      print(error);
    },);
  }

  @override
  void initState() {
    // TODO: implement initState
    getUswerlist();
  }

  //for male
  List<Users> maleList=[];

  List<Users> _formale( List<Users> list){
    for(var element in list){
      if(element.gender=='male'){
        maleList.add(element);
      }
    }
    return maleList;
  }


  List<Users> femaleList=[];

  List<Users> _forfemale(List<Users> list){
    for(var element in list){
      if(element.gender=='female'){
        femaleList.add(element);
      }
    }
    return femaleList;
  }
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Text('Filter API',style: TextStyle(color: Colors.white)),
            centerTitle: true,
            backgroundColor: Colors.red,
            elevation: 0,
            bottom: TabBar(
                tabs: <Widget>[
                  Text('Male',style: TextStyle(color: Colors.white,fontSize: 16)),
                  Text('Female',style: TextStyle(color: Colors.white,fontSize: 16)),
                ]
            ),
          ),
          body: TabBarView(
              children: [
               _maleusers(),
              _femaleusers(),
              ]
          ),
        )
    );
  }

  _maleusers(){
    return issloading==true ? Center(child: CircularProgressIndicator(),) :
      ListView.builder(
        itemCount: maleList.length,
        itemBuilder: (context, index) {
           return ListTile(
             leading: CircleAvatar(
               backgroundImage: NetworkImage(maleList[index].image.toString()),
             ),
             title: Text('${maleList[index].firstName.toString()} ${maleList[index].lastName.toString()}'),
             subtitle: Row(
               children: [
                 Text("Gender: ${maleList[index].gender.toString()}"),
                 SizedBox(width: 10,),
                 Text("Id:${maleList[index].id.toString()}")
               ],
             ),
             trailing: Text("Age: ${maleList[index].age.toString()}"),
           );
        },
    );
  }


  _femaleusers(){
    return issloading==true ? Center(child: CircularProgressIndicator(color: Colors.red,),) :
      ListView.builder(
      itemCount: femaleList.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(femaleList[index].image.toString()),
          ),
          title: Text('${femaleList[index].firstName.toString()} ${femaleList[index].lastName.toString()}'),
          subtitle: Text(femaleList[index].gender.toString()),
          trailing: Text("Age: ${femaleList[index].age.toString()}"),
        );
      },
    );
  }
}
