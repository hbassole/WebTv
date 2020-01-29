
import 'package:webtv_app/Utility/Const.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:webtv_app/Models/Video.dart';

class VideoService {

  static Future<List<Video>> browser({query})async {
    try {
      http.Response response = await http.get(
        "${Const.baseUrl}/video/", headers: Const.requestHeaders,
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        //print(data);
        Iterable<Video> _video = new List<Video>.from(
            data.map((x) => Video.fromJson(x)));

        if (query != null && query.isNotEmpty) {
          _video = _video.where(
                (video) => video.titre.toLowerCase().contains(query),);
        }
        return _video.toList();
      }
    } catch (error) {
      return null;
    }
  }

  static Future<Map<String, dynamic>> likeVideo({int id_user, String slug })async{

    Map<String, dynamic> userData = {
      "user" : id_user.toString(),
      "like" : slug,
    };
    print(userData);
    try{
      http.Response response = await http.post(
        "https://webtv.ipartage.net/api/like", headers: Const.requestHeaders,
        body: userData,
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data;
      }

      if(response.statusCode == 401){
        return throw Exception("vos identifiant ne correspondent pas ...");
      }

    }catch(error){
      print( error.toString());
      return null;
    }
  }

  static Future<Map<String, dynamic>> dislikeVideo({ int id_user, String slug })async{


    Map<String, dynamic> userData = {
      "user" : id_user.toString(),
      "dislike" : slug,
    };



    try{

      http.Response response = await http.post(
        "https://webtv.ipartage.net/api/dislike", headers: Const.requestHeaders,
        body: userData,
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data;
      }

      if(response.statusCode == 401){
        return throw Exception("vos identifiant ne correspondent pas ...");
      }

    }catch(error){
      print("error");
      return null;
    }
  }

  static Future<Map<String, dynamic>> commentVideo({ int id_user, String messages , String slug })async{

    Map<String, dynamic> userData = {
      "video" : slug,
      "user" : id_user.toString(),
      "messages" : messages,
    };

    try{

      http.Response response = await http.post(
        "https://webtv.ipartage.net/api/like/", headers: Const.requestHeaders,
        body: userData,
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data;
      }

      if(response.statusCode == 401){
        return throw Exception("vos identifiant ne correspondent pas ...");
      }

    }catch(error){
      print("error");
      return null;
    }
  }

  static Future<Map<String, dynamic>> postVideo({ id_user, String nameFile,String titleVideo })async{

    Map<String, dynamic> userData = {
      "user" : id_user,
      "name_video" : nameFile,
      "title_video": titleVideo,
    };

    try{

      http.Response response = await http.post(
        "https://webtv.ipartage.net/api/like/", headers: Const.requestHeaders,
        body: json.encode(userData),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data;
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

/*

void main()async{

  var contact = await VideoService.likeVideo(id_user: 1, slug: "le-colonel-watao-est-m0rt-1f0e3dad99908345f7439f8ffabdffc4");
  print(contact);

}

 */
