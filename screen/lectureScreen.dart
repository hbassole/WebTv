import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_youtube/flutter_youtube.dart';
import 'package:video_player/video_player.dart';

class LectureScreen extends StatefulWidget {
  String url;

  LectureScreen({this.url});

  @override
  _LectureScreenState createState() => _LectureScreenState();
}

class _LectureScreenState extends State<LectureScreen>
    with TickerProviderStateMixin {
  VideoPlayerController _controller;
  ChewieController _chewieController;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.url);
    _chewieController = ChewieController(
        videoPlayerController: _controller,
        aspectRatio: _controller.value.aspectRatio,
        showControlsOnInitialize: true,
        autoPlay: true
        
        );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    _chewieController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.black,
        appBar: AppBar(),
        body: Container(
          height: MediaQuery.of(context).size.height,
          width :MediaQuery.of(context).size.width,
          
          child:selectPlayer()));
  }

  Widget selectPlayer() {
    if (widget.url.toString().toLowerCase().endsWith(".mp4")) {
      return Chewie(
              controller: _chewieController,
            );
    } else {
      return FlutterYoutube.playYoutubeVideoByUrl(
          apiKey: "AIzaSyA8Ut3UNGe-RTuHTHtk9zklrkdwqNCDfAI",
          videoUrl: widget.url,
          //default falase
          appBarColor: Colors.black);
    }
  }
}
