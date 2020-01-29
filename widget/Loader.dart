import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';



class LoaderWebtv extends StatefulWidget {
  @override
  _LoaderWebtvState createState() => new _LoaderWebtvState();
}

class _LoaderWebtvState extends State<LoaderWebtv> {
  @override
  Widget build(BuildContext context) {
    return Center(child: Container(
        height: 100, width: 200, child: FlareActor("images/loader_rail.flr", alignment:Alignment.center, fit:BoxFit.contain, animation:"load")));
  }
}

class LoaderWebtvDirect extends StatefulWidget {
  @override
  _LoaderWebtvStateDirect createState() => new _LoaderWebtvStateDirect();
}

class _LoaderWebtvStateDirect extends State<LoaderWebtvDirect> {
  @override
  Widget build(BuildContext context) {
    return Center(child: Container(
         child: FlareActor("images/wait.flr", alignment:Alignment.center, fit:BoxFit.contain, animation:"wait")));
  }
}

/*
class LoaderWebtvDirect extends StatefulWidget {
  @override
  _LoaderWebtvStateDirect createState() => new _LoaderWebtvStateDirect();
}

class _LoaderWebtvStateDirect extends State<LoaderWebtvDirect> {
  @override
  Widget build(BuildContext context) {
    return Center(child: Container(height: 100, width: 200, child: FlareActor("images/loader_rail.flr", alignment:Alignment.center, fit:BoxFit.contain, animation:"wait")));
  }
}


class LoaderWebtvVideo  extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black12.withOpacity(.5),
      padding: EdgeInsets.all(5),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Row(children: <Widget>[
              Flexible(child: Container( height:250, decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: Colors.white.withOpacity(.3),
              ),),),
              SizedBox(width: 10,),
              Flexible(child: Container(height:250 ,decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: Colors.white.withOpacity(.3),
              ),),),
            ],),
            SizedBox(height: 20,),

            Row(children: <Widget>[
              Flexible(child: Container( height:250, decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: Colors.white.withOpacity(.3),
              ),),),
              SizedBox(width: 10,),
              Flexible(child: Container(height:250 ,decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: Colors.white.withOpacity(.3),
              ),),),
            ],),

            SizedBox(height: 20,),
            Row(children: <Widget>[
              Flexible(child: Container( height:250, decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: Colors.white.withOpacity(.3),
              ),),),
              SizedBox(width: 10,),
              Flexible(child: Container(height:250 ,decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: Colors.white.withOpacity(.3),
              ),),),
            ],),




          ],
        ),
      ),
    );
  }
}




class LoaderWebtvDirects extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
    color: Colors.black12.withOpacity(.5),
      padding: EdgeInsets.all(5),
      //color: Colors.black12,
      child: Column(
        children: <Widget>[
          Flexible(
            fit: FlexFit.loose,
            flex: 1,child: Container(
            height: 250,

            child: Row(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(left: 20),
                    height: 150,
                    width: 100,
                    child: CircleAvatar(backgroundColor: Color(0xffF1F1F1).withOpacity(.8),)),
              ],
            ),
          ),),
          Flexible(fit: FlexFit.loose,flex: 3,child: Container(
            child: Center(child: LoaderWebtv()),
            decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: Color(0xffF1F1F1).withOpacity(.8),
          ),),),
          SizedBox(height: 30,),
          Flexible(fit: FlexFit.loose,flex: 1, child: Container(
            height: 150,
            decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: Color(0xffF1F1F1).withOpacity(.8),
          ),),),
        ],
      ),
    );
  }
}

 */