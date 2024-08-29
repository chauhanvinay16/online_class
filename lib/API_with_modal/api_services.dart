

import 'dart:async';
import 'dart:convert';

import 'package:online_class/API_with_modal/single_post_modal.dart';
import 'package:http/http.dart' as http;
import 'package:online_class/model/resepe_modal.dart';

class Apiservices{


  //with Modal
  Future<singlepostmodal?> getsinglePostwithModal()async{
    try{
      var response=await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts/1'));
      if(response.statusCode==200){
        singlepostmodal modal=singlepostmodal.fromJson(jsonDecode(response.body));
        return modal;
      }
    }
    catch(e){
      print(e.toString());
    }
    return null;
  }
  
  // Future<List<ResepeModal?>>getresepedata()async{
  //   try{
  //     var response=await http.get(Uri.parse('https://dummyjson.com/recipes/1'));
  //
  //     if (response.statusCode == 200) {
  //       List<dynamic> jsonList = jsonDecode(response.body)['recipes'];
  //       return jsonList.map((json) => ResepeModal.fromJson(json)).toList();
  //     } else {
  //       throw Exception('Failed to load recipes');
  //     }
  //   }catch(e){
  //     print("Error${e.toString()}");
  //   }
  // }

  //without modal
  Future<dynamic> getsinglePostwithoutModal()async{
    try{
      var response=await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts/1'));
      if(response.statusCode==200){
        final data=jsonDecode(response.body);
        return data;
      }
    }
    catch(e){
      print(e.toString());
    }
    return null;
  }
  
  //emp without modal
  Future<dynamic>getempdata() async{
    try{
       var response=await http.get(Uri.parse('https://dummy.restapiexample.com/api/v1/employee/1'));
       if(response.statusCode==200){
         final data=jsonDecode(response.body);
         return data;
       }
    }
    catch(e){
      print(e.toString());
    }
  }

  Future<dynamic>getmovidata() async{
    try{
      var respons=await http.get(Uri.parse('https://dummyapi.online/api/movies/1'));
      if(respons.statusCode==200){
        final movidata=jsonDecode(respons.body);
        return movidata;
      }
    }
    catch(e){
        print(e.toString());
    }
  }
  
  Future<dynamic>getdummyuser()async{
    try{
      var response=await http.get(Uri.parse('https://dummyjson.com/users/1'));

      if(response.statusCode==200){
          final dummydata=jsonDecode(response.body);
          return dummydata;
      }
    }catch(e){
      print(e);
    }
  }

  Future<dynamic>getproductvinay()async{
    try{
      var respions=await http.get(Uri.parse('https://dummyjson.com/products'));
      final product=jsonDecode(respions.body);
      return product;

    }catch(e){
      print(e);
    }
  }


  static const String _baseUrl = 'https://api.escuelajs.co/api/v1/products/';

  Future<void> createProduct(String title, double price, String description, int categoryId, List<String> images) async {
    try{
      final url = Uri.parse(_baseUrl);

      final Map<String, dynamic> requestBody = {
        'title': title,
        'price': price,
        'description': description,
        'categoryId': categoryId,
        'images': images,
      };

      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(requestBody),
      );

      if (response.statusCode == 201) {
        print('Product created successfully');
        print(response);
      } else {
        print('Failed to create product: ${response.statusCode}');
      }
    }catch(e){
      print(e.toString());
    }
  }


  // Future<dynamic>updateuser(int id, String firstName, String lastName, String age) async{
  //     try{
  //         var response=await http.post(Uri.parse('https://dummyjson.com/users/$id'),
  //             headers: <String, String>{
  //               'Content-Type': 'application/json; charset=UTF-8',
  //             },
  //             body: jsonEncode(<String, dynamic>{
  //               'firstName': firstName,
  //               'lastName': lastName,
  //               'age': int.parse(age),
  //             }),
  //         );
  //         if(response.statusCode==200){
  //           final updatedata=jsonDecode(response.body);
  //           return updatedata;
  //         }
  //     }catch(e){
  //       print(e.toString());
  //     }
  // }

}