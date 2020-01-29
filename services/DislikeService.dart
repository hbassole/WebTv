
import 'package:webtv_app/Models/Dislike.dart';
import 'package:webtv_app/Utility/Const.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class DislikeService {

  static Future<List<Dislike>> browser({query})async {
    try {
      http.Response response = await http.get(
        "${Const.baseUrl}/dislike/", headers: Const.requestHeaders,
      );


      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        Iterable<Dislike> _cat = new List<Dislike>.from(
            data.map((x) => Dislike.fromJson(x)));


        if (query != null && query.isNotEmpty) {
          _cat = _cat.where(
                (dislike) => dislike.id.toString().contains(query),);
        }
        return _cat.toList();
      }
    } catch (error) {
      return null;    }
  }


}


/*

void main()async{
  var contact = await DislikeService.browser(query: "");
  print(contact.map((x)=> print(x.id)));

}
*/

