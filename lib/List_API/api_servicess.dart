import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:online_class/List_API/list_modal.dart';
import 'package:online_class/List_API/movimodal.dart';

class ApiServicess{


Future<List<PostModal>?>getpostmodal()async{
  try{
    var response=await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
    if(response.statusCode==200){
      List<PostModal> modal=List<PostModal>.from(json.decode(response.body).map((x)=> PostModal.fromJson(x)));
      return modal;
    }
  }
  catch(e){
    print(e.toString());
  }
}

Future<List<movimodal>?>getmovimodaldata() async{
  try{
      var respons=await http.get(Uri.parse('https://dummyapi.online/api/blogposts'));

      if(respons.statusCode==200){
        List<movimodal> modal=List<movimodal>.from(json.decode(respons.body).map((x)=>movimodal.fromJson(x)));
        return modal;
      }
  }catch(e){
      print(e.toString());
  }
}

Future<dynamic>getwithoutmodaldata() async{
  try{
    var respons=await http.get(Uri.parse('https://dummyapi.online/api/todos'));
    
    if(respons.statusCode==200){
      final data=jsonDecode(respons.body);
      return data;
    }
  }catch(e){
    print(e.toString());
  }
}

Future<dynamic>getprofiledata()async{
  try{
    var response=await http.get(Uri.parse('https://dummyapi.online/api/social-profiles'));

    if(response.statusCode==200){
      final data=jsonDecode(response.body);
      return data;
    }
  }catch(e){
    print(e.toString());
  }
}

Future<dynamic>getquetdata() async{
  try{
    var respones= await http.get(Uri.parse('https://dummyjson.com/quotes'));

    if(respones.statusCode==200){
      final qdata=jsonDecode(respones.body);
      return qdata;
    }
  }catch(e){
    print(e);
  }
}

}