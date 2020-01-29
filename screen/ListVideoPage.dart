import 'package:flutter/material.dart';
import 'package:webtv_app/Models/Video.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'lectureScreen.dart';


class ListVideoPage extends StatefulWidget {

  List<Video>video;
  ListVideoPage({this.video});

  @override
  _ListVideoPageState createState() => _ListVideoPageState();
}

class _ListVideoPageState extends State<ListVideoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
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
                    child: Text(widget.video[i].titre,style: TextStyle(
                        color: Colors.white, fontSize: 12
                    ),),
                  )),
                ),
                child: InkWell(
                  child: Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            
                            image: (widget.video[i].imagePreview != null )? CachedNetworkImageProvider(
                              widget.video[i].imagePreview,
                            ) : CachedNetworkImageProvider("http://img.youtube.com/vi/"+widget.video[i].videoUrl.substring(widget.video[i].videoUrl.length - 11)+"/hqdefault.jpg",)
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
        child: Text("Pas de concours disponible",style: TextStyle(color: Colors.white,fontSize: 25),),
      ),
    );
  }
}
