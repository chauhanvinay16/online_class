import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:online_class/filter_array/product_modal.dart';
import 'api_services.dart';

class Productfillter extends StatefulWidget {
  const Productfillter({super.key});

  @override
  State<Productfillter> createState() => _ProductfillterState();
}

class _ProductfillterState extends State<Productfillter> {

  bool isloading = false;

  getproductlist() {
    setState(() {
      isloading = true;
    });
    APISERVICESAR().Productlist().then((value) {
      setState(() {
        _fregrences(value!.products!);
        _beautylist(value!.products!);
        isloading = false;
        print(value?.products?.length??0);
        print(jsonEncode(value));
      });
    },).onError((error, stackTrace) {
      print(error);
    },);
  }

  @override
  void initState() {
    // TODO: implement initState
    getproductlist();
  }

  List<Products> fregrancelist = [];

  List<Products> _fregrences(List<Products> list) {
    for (var element in list) {
      if (element.category == 'fragrances') {
        fregrancelist.add(element);
      }
    }
    return fregrancelist;
  }

  List<Products>beautiylist = [];

  List<Products> _beautylist(List<Products> list) {
    for (var element in list) {
      if (element.category == 'groceries') {
        beautiylist.add(element);
      }
    }
    return beautiylist;
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Text(
                'Product Filter API', style: TextStyle(color: Colors.white)),
            centerTitle: true,
            backgroundColor: Colors.blue,
            elevation: 0,
            bottom: TabBar(
                tabs: <Widget>[
                  Text('Apple',
                      style: TextStyle(color: Colors.white, fontSize: 16)),
                  Text('Samsung',
                      style: TextStyle(color: Colors.white, fontSize: 16)),
                ]
            ),
          ),
          body: TabBarView(
              children: [
                fregrence(),
                beauty(),
              ]
          ),
        )
    );
  }

  fregrence() {
    return isloading == true ? Center(child: CircularProgressIndicator(),) :
    ListView.builder(
      itemCount: fregrancelist.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: CircleAvatar(
            child: Text(fregrancelist[index].id.toString()),
          ),
          title: Text(fregrancelist[index].category.toString()),
          subtitle: Text(fregrancelist[index].description.toString()),
          trailing: Text("Rating: ${fregrancelist[index].rating.toString()}",style: TextStyle(color: Colors.red),),
        );
      },
    );
  }

  beauty() {
    return isloading == true ? Center(child: CircularProgressIndicator(),) :
    ListView.builder(
      itemCount: beautiylist.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: CircleAvatar(
            child: Text(beautiylist[index].id.toString()),
          ),
          title: Text(beautiylist[index].category.toString()),
          subtitle: Text(beautiylist[index].description.toString()),
          trailing: Text("Rating: ${beautiylist[index].rating.toString()}",style: TextStyle(color: Colors.red),),
        );
      },
    );
  }

}

