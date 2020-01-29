import 'package:flutter/material.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';
import 'package:webtv_app/Models/Video.dart';
import 'package:webtv_app/manager/LikeManager.dart';
import 'package:webtv_app/screen/playeur.dart';

class Detail extends StatefulWidget {

  List<Video> mesVideo;
  final String url ;

  Detail({this.mesVideo, this.url});

  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> {

  AutoScrollController controller = AutoScrollController();
  String name;
  int id_user;

  void initState() {
    super.initState();
    controller.scrollToIndex(widget.mesVideo.length);
    getName();
  } 
  getName()async{
    SharedPreferences shared_user = await SharedPreferences.getInstance();
    setState(() {
      name = shared_user.getString("username");
      id_user = shared_user.getInt("id");
    });
  }



  @override
  void dispose() {
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(),
      body: Container(
        color: Colors.black,
        child: Column(
          children: <Widget>[
            Expanded(
                child:ListView.builder(
                    itemCount: widget.mesVideo.length,
                    controller: controller,
                    itemBuilder: (context,i){
                  
                      return AutoScrollTag(
                        
                        key: ValueKey(i),
                        controller: controller,
                        index: i,
                        child: new PlayeurPage(video: widget.mesVideo[i],id: id_user,username: name,),
                      );
                    }))
          ],
        ),
      ),
    );
  }
}
