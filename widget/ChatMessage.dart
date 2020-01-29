
import 'package:flutter/material.dart';

class ChatMessage extends StatelessWidget {

  ChatMessage({this.text, this.animationController, this.username});
  final String text;
  final String username;
  final AnimationController animationController;
  @override
  Widget build(BuildContext context) {

    final animation = Tween(begin: 0.0, end: 1.0).animate(animationController);

    return new SizeTransition(
        sizeFactor: new CurvedAnimation(
          //new
            parent: animationController,
            curve: Curves.easeOut,
        ), //new
        axisAlignment: 0.0,
        child: new Container(
          //modified
          margin: const EdgeInsets.symmetric(vertical: 10.0),
          child: new Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new Container(
                margin: const EdgeInsets.only(right: 16.0),
                child: new CircleAvatar(child: new Text(username.substring(0,1).toUpperCase()), backgroundColor: Colors.red.withOpacity(.5),),
              ),
              new Expanded(
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    new Text(username, style: TextStyle(color: Colors.white)),
                    new Container(
                      margin: const EdgeInsets.only(top: 5.0),
                      child: new Text(text,style: TextStyle(color: Colors.white),),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ) // new
    );
  }
}