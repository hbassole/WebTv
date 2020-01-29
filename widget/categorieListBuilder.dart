import 'package:flutter/material.dart';
import 'package:webtv_app/Models/Categorie.dart';
import 'package:webtv_app/widget/Observer.dart';

class CategoriesListBuilder extends StatelessWidget {
  @required
  final Function builder;
  final Stream stream;

  CategoriesListBuilder({this.builder, this.stream});


  @override
  Widget build(BuildContext context) {

    return Observer<List<Categorie>>(
      streams: stream,
      onSuccess: (BuildContext context,  data) =>  builder(context, data),
      onWaiting : (context) => LinearProgressIndicator(),

    );

  }
}