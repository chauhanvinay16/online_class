import 'dart:convert';
import 'package:http/http.dart' as http;
import 'modal.dart';

class Apiservicescreate{

  Future<Postmodal?>createjob(String email,String job)async{
    try{
        var respons=await http.post(Uri.parse('https://reqres.in/api/users'),body: {
          "name": email,
          "job": job,
        });
        if(respons.statusCode==201 || respons.statusCode==200){
          Postmodal modal=Postmodal.fromJson(jsonDecode(respons.body));
          return modal;
        }
    }catch(e){
      print(e);
    }
  }

  Future<dynamic>LoginAPI(String mobileNo,String password,String deviceToken,String deviceType) async{
    final url = Uri.parse('https://inventory.vibrantcoders.in/public/api/login');
    final headers = {'Content-Type': 'application/json'};
    final body = json.encode({
      'mobile_no': mobileNo,
      'password': password,
      'device_token': deviceToken,
      'device_type': deviceType,
    });

    try {
      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        // Handle success
        print('**********API HIT********');
        print('Response data: ${response.body}');
      } else {
        // Handle error
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (e) {
      // Handle exception
      print('Request failed with error: $e');
    }

  }
}