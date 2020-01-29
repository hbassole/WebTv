
import 'package:webtv_app/Models/Direct.dart';
import 'package:webtv_app/Models/Like.dart';
import 'package:webtv_app/Utility/Const.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class LikeService {

  static Future<List<Like>> browser({query})async {
    try {
      http.Response response = await http.get(
        "${Const.baseUrl}/like/", headers: Const.requestHeaders,
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        Iterable<Like> _cat = new List<Like>.from(
            data.map((x) => Like.fromJson(x)));
        //await Future.delayed(Duration(seconds: 1));

        if (query != null && query.isNotEmpty) {
          _cat = _cat.where(
                (like) => like.id.toString().contains(query),);
        }
        return _cat.toList();
      }
    } catch (error) {
      return null;    }
  }


}

/*
void main()async{
  var contact = await LikeService.browser(query: "");
  print(contact.map((x)=> print(x.id)));

}

 */
