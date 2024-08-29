import 'package:shared_preferences/shared_preferences.dart';

class StoraheHelper {
  static final StoraheHelper _singleton = StoraheHelper._internal();

  factory StoraheHelper() {
    return _singleton;
  }

  StoraheHelper._internal();

  late SharedPreferences sp;

  Future<void>init()async{
    sp=await SharedPreferences.getInstance();
  }

  void setUserBearerToken(String value){
    sp.setString('UserBearerToken', value);
  }

  void cleardata(){
    sp.clear();
  }

  String getUserBearerToken(){
      return sp.getString("UserBearerToken")??"";
  }
}