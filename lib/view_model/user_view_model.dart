
import 'package:flutter/foundation.dart';
import 'package:mvvm/model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserViewModel with ChangeNotifier{
  Future<bool> saveUser(UserModel user) async{
    final SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setString('token', user.data!.token.toString());
    notifyListeners();
    return true;
  }
  Future<String> getUser() async{
    final SharedPreferences sp = await SharedPreferences.getInstance();
    final String? token = sp.getString('token');
    return token.toString();
  }
  Future<bool> remove() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    sp.remove('token');
    //return sp.clear();
    return true;
  }
}