import 'package:flutter/material.dart';
import 'package:webtv_app/Models/Direct.dart';
import 'package:webtv_app/widget/Observer.dart';
import 'package:webtv_app/widget/Loader.dart';

class DirectListBuilder extends StatelessWidget {
  @required
  final Function builder;
  final Stream stream;

  DirectListBuilder({this.builder, this.stream});


  @override
  Widget build(BuildContext context) {

    return Observer<List<Direct>>(
      streams: stream,
      onSuccess: (BuildContext context,  data) =>  builder(context, data),
      onWaiting : (context) => LoaderWebtv(),
    );

  }
}