import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:online_class/filter_array/product_modal.dart';

import 'modal.dart';

class APISERVICESAR{
  Future<UserListe?>userlistdata()async{
    try{
      var response=await http.get(Uri.parse('https://dummyjson.com/users'));
      if(response.statusCode==200){
        return UserListe.fromJson(jsonDecode(response.body));
      }
    }catch(e){
      print(e.toString());
    }
  }

  Future<Product?>Productlist() async{
    try{
      var response=await http.get(Uri.parse('https://dummyjson.com/products'));

      if(response.statusCode==200){
        return Product.fromJson(jsonDecode(response.body));
      }
    }catch(e){
      print(e);
    }
  }
}