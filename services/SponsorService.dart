
import 'package:webtv_app/Models/Sponsor.dart';
import 'package:webtv_app/Utility/Const.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class SponsorService {

  static Future<List<Sponsor>> browser({query})async {
    try {
      http.Response response = await http.get(
        "${Const.baseUrl}/sponsor/", headers: Const.requestHeaders,
      );


      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print(data);
        Iterable<Sponsor> _cat = new List<Sponsor>.from(
            data.map((x) => Sponsor.fromJson(x)));


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
  var contact = await SponsorService.browser(query: "");
  print(contact.map((x)=> print(x.id)));

}



 */