
import 'package:webtv_app/Models/Vue.dart';
import 'package:webtv_app/Utility/Const.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class VueService {

  static Future<List<Vue>> browser({query})async {
    try {
      http.Response response = await http.get(
        "${Const.baseUrl}/vue/", headers: Const.requestHeaders,
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        Iterable<Vue> _video = new List<Vue>.from(
            data.map((x) => Vue.fromJson(x)));
        //await Future.delayed(Duration(seconds: 1));

        if (query != null && query.isNotEmpty) {
          _video = _video.where(
                (vue) => vue.ip.toLowerCase().contains(query),);
        }
        return _video.toList();
      }
    } catch (error) {
      return null;
    }
  }


}




/*

void main()async{


  Duration interval = Duration(milliseconds: 200);
  callback(value)=> value+=1;
  Stream stream = Stream.periodic(interval, callback);

  await for(int i in stream){
    print(i);
  }

  /*
  var contact = await VueService.browser(query: "");
  print(contact.map((x)=> print(x.ip)));

   */

}


 */


