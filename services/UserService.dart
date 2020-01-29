
import 'package:webtv_app/Models/UserLogin.dart';
import 'package:webtv_app/Utility/Const.dart';
import 'package:webtv_app/Models/User.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class UserService {

  static Future<List<User>> browser({query})async {
    try {
      http.Response response = await http.get(
        "${Const.baseUrl}/user/", headers: Const.requestHeaders,
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        Iterable<User> _user = new List<User>.from(
            data.map((x) => User.fromJson(x)));
        //await Future.delayed(Duration(seconds: 1));

        //print(_user.toList());



        if (query != null && query.isNotEmpty) {
          _user = _user.where(
                (user) => user.username.toString().contains(query),);
        }
        return _user.toList();
      }
    } catch (error) {
      return null;
    }
  }


  static Future<UserLogin> login({String username, String password})async{

        Map<String, dynamic> userData = {
          "username" : username,
          "password" : password,
        };

    try{

      http.Response response = await http.post(
        "https://webtv.ipartage.net/api/loginapi", headers: Const.requestHeaders,
        body: json.encode(userData),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        UserLogin _user = UserLogin.fromJson(data);

        print("debut");
        return _user;
      }

      if(response.statusCode == 401){
        return throw Exception("vos identifiant ne correspondent pas ...");
      }

    }catch(error){
      print("error");
      return null;
    }
  }






}



void main()async{
  UserLogin contact = await UserService.login(username: "admin", password: "admin");
  print(contact.user.contact);

}



