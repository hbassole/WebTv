
import 'package:webtv_app/Utility/Const.dart';
import 'package:webtv_app/Models/Categorie.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class CategoriesService {

  static Future<List<Categorie>> browser({query})async {
    try {
      http.Response response = await http.get(
        "${Const.baseUrl}/categorie/", headers: Const.requestHeaders,
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        Iterable<Categorie> _cat = new List<Categorie>.from(
            data.map((x) => Categorie.fromJson(x)));
        //await Future.delayed(Duration(seconds: 1));



        if (query != null && query.isNotEmpty) {
          _cat = _cat.where(
                (categories) => categories.nom.toLowerCase().contains(query),);
        }
        return _cat.toList();
      }
    } catch (error) {
      return null;    }
  }


}

/*

void main()async{
  var contact = await CategoriesService.browser(query: "");
  print(contact.map((x)=> print(x.categorieVideo.map((x)=> x.titre))));

}

 */


