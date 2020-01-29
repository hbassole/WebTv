import 'package:flutter/material.dart';
import 'package:webtv_app/widget/Loader.dart';
import 'package:webtv_app/widget/Observer.dart';
import 'package:webtv_app/Models/Video.dart';

class VideoListBuilder extends StatelessWidget {
  @required
  final Function builder;
  final Stream stream;

  VideoListBuilder({this.builder, this.stream});


  @override
  Widget build(BuildContext context) {

    return Observer<List<Video>>(
      streams: stream,
      onSuccess: (BuildContext context,  data) =>  builder(context, data),
      onWaiting : (context) => LoaderWebtv(),

    );

  }
}