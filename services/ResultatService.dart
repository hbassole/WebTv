import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:webtv_app/Models/Resultat.dart';
import 'package:webtv_app/Utility/Const.dart';

class ResultatService {

  static Future<List<Resultat>> browser({query})async {
    try {
      http.Response response = await http.get(
        "${Const.baseUrl}/resultat/", headers: Const.requestHeaders,
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        Iterable<Resultat> _video = new List<Resultat>.from(
            data.map((x) => Resultat.fromJson(x)));
        //await Future.delayed(Duration(seconds: 1));

        if (query != null && query.isNotEmpty) {
          _video = _video.where(
                (res) => res.id.toString().contains(query),);
        }
        return _video.toList();
      }
    } catch (error) {
      return null;
    }
  }


}
