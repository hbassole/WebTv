import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:webtv_app/Models/Categorie.dart';
import 'package:webtv_app/screen/lectureScreen.dart';
import 'package:webtv_app/manager/VideoManager.dart';
import 'package:webtv_app/provider/provider.dart';
import 'package:webtv_app/widget/Color.dart';
import 'package:webtv_app/widget/videoListBuilder.dart';

class CategorieScreen extends StatefulWidget {


  List<CategorieVideo> video;
  CategorieScreen({this.video});


  @override
  _CategorieScreenState createState() => _CategorieScreenState();
}

class _CategorieScreenState extends State<CategorieScreen> with AutomaticKeepAliveClientMixin {

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.black,
      body: (!widget.video.isEmpty)? Container(
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,mainAxisSpacing: 20, crossAxisSpacing:10, childAspectRatio: 2/3),
            itemCount: widget.video?.length ?? 0,
            itemBuilder: (context, i){

              return GridTile(
                footer: Container(
                  height: 50,
                  color: Colors.black87,
                  child: Center(child: Container(
                    padding: EdgeInsets.all(10),
                    child: Text(utf8convert(widget.video[i].titre),style: TextStyle(
                        color: Colors.white, fontSize: 12
                    ),),
                  )),
                ),
                child: InkWell(
                  child: Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: (widget.video[i].imageUrl != null )? CachedNetworkImageProvider(
                              widget.video[i].imageUrl,
                            ) : CachedNetworkImageProvider("http://img.youtube.com/vi/"+widget.video[i].video.substring(widget.video[i].video.length - 11)+"/hqdefault.jpg",)
                        ),
                        borderRadius: BorderRadius.circular(15)
                    ),
                    child: Stack(
                      fit: StackFit.expand,
                      children: <Widget>[
                        FractionallySizedBox(
                          heightFactor: 0.4,
                          widthFactor: 0.4,
                          child: Container(
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.black.withOpacity(0.4)
                            ),
                            child:  IconButton(
                              onPressed: ()=>Navigator.push(context, MaterialPageRoute(builder: (ctx)=> LectureScreen(url: widget.video[i].video,) )),
                              icon: Icon(Icons.play_arrow, size: 35, color: Colors.white,),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          )
        ): Container(
        padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/4),
        alignment: Alignment.topCenter,
      child: Text("Pas de videos disponible",style: TextStyle(color: Colors.white,fontSize: 25),),
      ),
    );
  }
}