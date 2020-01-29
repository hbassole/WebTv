import 'package:flutter/material.dart';
import 'package:webtv_app/widget/listmenu.dart';
import 'package:video_player/video_player.dart';



class AcceuilPage extends StatefulWidget {
  @override
  _AcceuilPageState createState() => _AcceuilPageState();
}

class _AcceuilPageState extends State<AcceuilPage> with AutomaticKeepAliveClientMixin {

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: <Widget>[
          Container(
            child: listMenu(context: context,nom: "Recent",),
          ),
          Container(
              child: listMenu(context: context,nom: "Popular",)
          )
        ],
      ),
    );
  }
}
