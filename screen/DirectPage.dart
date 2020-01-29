import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_youtube/flutter_youtube.dart';
import 'package:webtv_app/screen/lectureScreen.dart';
import 'package:webtv_app/widget/Color.dart';
import 'package:flutter/material.dart';
import 'package:webtv_app/Models/Direct.dart';
import 'package:webtv_app/manager/DirectManager.dart';
import 'package:webtv_app/provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:webtv_app/widget/directListBuilder.dart';

class DirectPage extends StatefulWidget {
  @override
  _DirectPageState createState() => _DirectPageState();
}

class _DirectPageState extends State<DirectPage>
    with AutomaticKeepAliveClientMixin {
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  double opacite = 0.0;

  void opacitychange() {
    setState(() {
      opacite = opacite == 0.0 ? 1.0 : 0.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    ScreenUtil.init(context, width: 750, height: 1334, allowFontScaling: true);

    DirectManager manager = Provider.of(context).fetch(DirectManager);
    manager.inFilter.add("");

    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: Column(
            children: <Widget>[
              Text(
                "DIRECT",
                style: TextStyle(
                  color: HexColor("#D0CECE"),
                ),
              ),
              Icon(
                Icons.videocam,
                size: height * 0.03,
                color: Colors.red,
              )
            ],
          ),
        ),
        body: DirectListBuilder(
            stream: manager.browser$,
            builder: (context, data) {
              return Container(
                height: ScreenUtil.screenHeight,
                child: PageView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: data?.length,
                    itemBuilder: (context, i) {
                      Direct direct = data[i];
                      //print(direct.miniDescription);

                      return Container(
                        child: Column(
                          children: <Widget>[
                            Expanded(
                                flex: 1,
                                child: Container(
                                  padding: EdgeInsets.only(
                                      left: 20, bottom: 5, top: 5),
                                  child: Row(
                                    children: <Widget>[
                                      CircleAvatar(
                                        backgroundColor: Colors.red,
                                        radius: 30,
                                        child: Text(direct.auteur.username
                                            .substring(0, 1)
                                            .toUpperCase()),
                                      ),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Text(
                                        direct.auteur.username,
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ],
                                  ),
                                )),
                            Expanded(
                              flex: 5,
                              child: GestureDetector(
                                onTap: () {
                                  FlutterYoutube.playYoutubeVideoByUrl(
                                      apiKey:
                                          "AIzaSyA8Ut3UNGe-RTuHTHtk9zklrkdwqNCDfAI",
                                      videoUrl: direct.videoUrl,
                                      autoPlay: true, //default falase
                                      fullScreen: true,
                                      appBarColor: Colors.black //default false
                                      );
                                },
                                child: Container(
                                  child: (direct.imageUrl != null)
                                      ? CachedNetworkImage(
                                          imageUrl: direct.imageUrl,
                                        )
                                      : CachedNetworkImage(
                                          imageUrl:
                                              "http://img.youtube.com/vi/" +
                                                  direct.videoUrl.substring(
                                                      direct.videoUrl.length -
                                                          11) +
                                                  "/hqdefault.jpg",
                                          fit: BoxFit.contain,
                                        ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      margin:
                                          EdgeInsets.only(top: 10, left: 20),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Wrap(
                                            children: <Widget>[
                                              Text(
                                                utf8convert(direct.titre),
                                                maxLines: 1,
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              SizedBox(
                                                width: 20,
                                              ),
                                              Text(
                                                utf8convert(
                                                    direct.miniDescription),
                                                maxLines: 2,
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                    color: Colors.white),
                                              )
                                            ],
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            children: <Widget>[],
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      );
                    }),
              );
            }));
  }
}
