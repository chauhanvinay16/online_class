import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:online_class/List_API/api_servicess.dart';

class Apiwithoutmodallist extends StatefulWidget {
  const Apiwithoutmodallist({super.key});

  @override
  State<Apiwithoutmodallist> createState() => _ApiwithoutmodallistState();
}

class _ApiwithoutmodallistState extends State<Apiwithoutmodallist> {

  // bool isready = false;
  // dynamic postlist = [];
  //
  // _getlistdata() {
  //   ApiServicess().getwithoutmodaldata().then((value) {
  //     setState(() {
  //       isready = true;
  //       postlist = value!;
  //       print('***************API HIT******************* $postlist');
  //     });
  //   },).onError((error, stackTrace) {
  //     print(error);
  //   },);
  // }
  //
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   _getlistdata();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Without Modal'),
        ),
        body: FutureBuilder(
          future: ApiServicess().getwithoutmodaldata(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      leading: CircleAvatar(
                        child: Text(snapshot.data[index]['id'].toString()),
                      ),
                      title: Text(snapshot.data[index]['title']),
                      subtitle: Text(snapshot.data[index]['priority']),
                    ),
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            } else {
              return Center(
                child: CustomCircularProgressIndicator(),
              );
            }
          },

        )
    );
  }
}

class CustomCircularProgressIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.all(16.0),
      child: Stack(
        alignment: Alignment.center,
        children: [
          LoadingAnimationWidget.flickr(size: 60, leftDotColor: Colors.red, rightDotColor: Colors.blue)
        ],
      ),
    );
  }
}