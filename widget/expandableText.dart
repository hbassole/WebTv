import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ExpandableText extends StatefulWidget {

  final String text;
  ExpandableText({this.text});

  @override
  _ExpandableTextState createState() => new _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText>
    with TickerProviderStateMixin<ExpandableText> {

  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {

    ScreenUtil.init(context, width: 414, height: 896);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
      Container(
        padding: EdgeInsets.only(right: 10),
        child: new AnimatedSize(
            vsync: this,
            duration: const Duration(milliseconds: 500),
            child: new ConstrainedBox(
                constraints: isExpanded
                    ? new BoxConstraints()
                    : new BoxConstraints(maxHeight: ScreenUtil().setHeight(30)),
                child: new Text(
                  widget.text,
                  maxLines: 3,
                  softWrap: true,
                  overflow: TextOverflow.fade,
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                      fontSize: ScreenUtil().setSp(14),
                      //fontWeight: FontWeight.w500,
                    color: Colors.white
                  ),
                ))),
      ),
          (widget.text.length > 90)?
            isExpanded
            ?  new FlatButton(
            child: Text('Voir moins', style: TextStyle(fontWeight: FontWeight.w600, fontSize: ScreenUtil().setSp(14),color: Colors.white),),
            onPressed: () => setState(() => isExpanded = !isExpanded))
                : new FlatButton(
            child: Text('Voir plus', style: TextStyle(fontWeight: FontWeight.w600, fontSize: ScreenUtil().setSp(14), color: Colors.white)),
            onPressed: () => setState(() => isExpanded = !isExpanded)):  Container(),

    ]);
  }
}