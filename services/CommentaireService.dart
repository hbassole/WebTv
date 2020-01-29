
import 'package:webtv_app/Utility/Const.dart';
import 'package:webtv_app/Models/Commentaire.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class CommentaireService {

  static Future<List<Commentaire>> browser({query})async {
    try {
      http.Response response = await http.get(
        "${Const.baseUrl}/commentaire/", headers: Const.requestHeaders,
      );

      print("ZERTYUIERTYUIRTYUIDFGHJKDFGHJKLFGHJKLFGHJK");
      print(response.body);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print(data);
        Iterable<Commentaire> _comment = new List<Commentaire>.from(
            data.map((x) => Commentaire.fromJson(x)));
        //await Future.delayed(Duration(seconds: 1));

        if (query != null && query.isNotEmpty) {
          _comment = _comment.where(
                (categories) => categories.id.toString().contains(query),);
        }

        return _comment.toList();
      }
    } catch (error) {
      return null;    }
  }


}

/*
void main()async{
  var contact = await CommentaireService.browser();
  print(contact.map((x)=> print(x.response[0].id)));
  print(contact.map((x)=> print(x.response[0].message)));
  print(contact.map((x)=> print(x.response[0].user)));

}


 */
