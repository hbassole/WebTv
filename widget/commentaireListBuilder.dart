import 'package:flutter/material.dart';
import 'package:webtv_app/widget/Observer.dart';
import 'package:webtv_app/Models/Commentaire.dart';

class CommentaireListBuilder extends StatelessWidget {
  @required
  final Function builder;
  final Stream stream;

  CommentaireListBuilder({this.builder, this.stream});


  @override
  Widget build(BuildContext context) {

    return Observer<List<Commentaire>>(
      streams: stream,
      onSuccess: (BuildContext context,  data) =>  builder(context, data),
      onWaiting : (context) => LinearProgressIndicator(),

    );

  }
}