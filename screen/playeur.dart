import 'package:cached_network_image/cached_network_image.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_youtube/flutter_youtube.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';
import 'package:webtv_app/Models/Video.dart';
import 'package:webtv_app/screen/CommentPage.dart';
import 'package:webtv_app/services/VideoService.dart';
import 'package:webtv_app/widget/Color.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';


class PlayeurPage extends StatefulWidget {
  Video video;
  final String username;
  final int id;

  PlayeurPage({this.video, this.id, this.username});
  @override
  _PlayeurPageState createState() => _PlayeurPageState();
}

class _PlayeurPageState extends State<PlayeurPage> with AutomaticKeepAliveClientMixin{


  VideoPlayerController _controller;
  YoutubePlayerController _youtubePlayerController;
  ChewieController _chewieController;

  bool isLike = true;

 

   @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  
    if (widget.video.video.toString().endsWith('.mp4')) {
        _controller = VideoPlayerController.network(
        widget.video.video,);
    _chewieController=ChewieController(
      videoPlayerController: _controller,
      aspectRatio: _controller.value.aspectRatio,
      showControlsOnInitialize: true,

    );
      
    }else{
          _youtubePlayerController=YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(widget.video.video),
    
 
    );

    }

    
  }
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                
                height: height*0.4,
                width: width,
                child: Center(
                  child: selectPlayerDetail(),
                )
              ),

            ],
          ),
        ),
        ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.red.withOpacity(.5),
            radius: 40,
            child: Text("H"),
          ),
          title:Text(
            utf8convert(widget.video.miniDescription),
            style: TextStyle(color: Colors.white70, fontSize: 16),
            maxLines: 3,
          ) ,
        ),
        SizedBox(
          height: 20,
        ),
        Column(
          children: <Widget>[
            Divider(
              color: Colors.white,
            ),
            Container(
              padding:EdgeInsets.only(top: 5,bottom: 5),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Container(

                      child: Row(
                        children: <Widget>[
                          GestureDetector(
                            onTap : ()async{

                            if(isLike){
                              setState(() {
                                  widget.video.videoLike.length +=1 ;
                                });
                                isLike = !isLike;
                            }else{
                              isLike = !isLike;
                              setState(() {
                                  widget.video.videoLike.length -=1 ;
                                });
                            }

                            try{
                              await VideoService.likeVideo(id_user: widget.id, slug: widget.video.titreSlug);

                            }catch(e){
                              return null;
                            }

                            },
                            child: Icon(
                              Icons.favorite_border,
                              color: Colors.white,
                            ),
                          ),

                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            widget.video.videoLike.length.toString(),
                            style: TextStyle(color: (isLike)? Colors.red: Colors.white,fontSize: 18),
                          )
                        ],
                      )),
                  GestureDetector(
                    onTap: ()=>Navigator.push(context, MaterialPageRoute(
                        builder: (context)=>CommentPage(comment: widget.video.videoCommentaire, id: widget.id, slug: widget.video.titreSlug,username: widget.username,)
                    )),
                    child: Container(
                      child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.chat_bubble,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Commenter",
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap:(){
                      Share.share(widget.video.videoUrl,subject: widget.video.titre);

                    },
                    child: Container(
                      child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.share,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Partager",
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  )

                ],
              ),
            ),
            Divider(
              color: Colors.white,
            ),
          ],
        ),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }

  Widget selectPlayerDetail() {
    if (widget.video.video.endsWith(".mp4")) {
      return Chewie(
              controller: _chewieController,
            );
    } else {
      return YoutubePlayer(
        controller: _youtubePlayerController,
        
      )
      ;
    }
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
    _chewieController.dispose();
  }
}
