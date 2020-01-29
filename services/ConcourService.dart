
import 'package:webtv_app/Models/Concour.dart';
import 'package:webtv_app/Models/Direct.dart';
import 'package:webtv_app/Utility/Const.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ConcourService {

  static Future<List<Concour>> browser({query})async {
    try {
      http.Response response = await http.get(
        "${Const.baseUrl}/concour/", headers: Const.requestHeaders,
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        Iterable<Concour> _cat = new List<Concour>.from(
            data.map((x) => Concour.fromJson(x)));
        //await Future.delayed(Duration(seconds: 1));



        if (query != null && query.isNotEmpty) {
          _cat = _cat.where(
                (concour) => concour.titre.toString().contains(query),);
        }
        return _cat.toList();
      }
    } catch (error) {
      return null;    }
  }


}

/*
void main()async{
  var contact = await ConcourService.browser(query: "");
  print(contact.map((x)=> print(x.titre)));

}


 */