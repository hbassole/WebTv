import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'dart:io';


class PostPage extends StatefulWidget {
  File video;
  File cameravideo;

  PostPage({this.video,this.cameravideo});

  @override
  _PostPageState createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  TextEditingController titre;
  VideoPlayerController _videoPlayerController;
  VideoPlayerController _cameraVideoPlayerController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _videoPlayerController = VideoPlayerController.file(widget.video)..initialize().then((_) {
      setState(() { });
      _videoPlayerController.play();
    });

    _cameraVideoPlayerController = VideoPlayerController.file(widget.cameravideo)..initialize().then((_) {
      setState(() { });
      _cameraVideoPlayerController.play();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Center(
            child: AspectRatio(
              aspectRatio: (widget.video==null)?_videoPlayerController.value.aspectRatio:_cameraVideoPlayerController.value.aspectRatio,
              child: (widget.video==null)?VideoPlayer(_videoPlayerController):VideoPlayer(_videoPlayerController),
            ),
          ),
          Row(
            children: <Widget>[
              new Flexible(
                child: new TextField(
                  controller: titre,
                  decoration:
                  new InputDecoration.collapsed(hintText: "Send a message"),
                ),
              ),
              new Container(
                margin: new EdgeInsets.symmetric(horizontal: 4.0),
                child: new IconButton(
                  icon: new Icon(Icons.send),
                  onPressed:() => null,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
