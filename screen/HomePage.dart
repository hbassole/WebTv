import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:webtv_app/Models/Categorie.dart';
import 'package:webtv_app/manager/CategorieManager.dart';
import 'package:webtv_app/manager/VideoManager.dart';
import 'package:webtv_app/provider/provider.dart';
import 'package:webtv_app/screen/CategoriePage/Acceuil.dart';
import 'package:webtv_app/screen/NotificationPage.dart';
import 'package:webtv_app/screen/categorieView.dart';
import 'package:webtv_app/widget/Color.dart';
import 'package:webtv_app/widget/Observer.dart';
import 'package:webtv_app/widget/drawer.dart';
import 'package:webtv_app/widget/listmenu.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
import 'package:carousel_pro/carousel_pro.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    ScreenUtil.init(context, width: 750, height: 1334, allowFontScaling: true);

    VideoManager manager = Provider.of(context).fetch(VideoManager);
    CategoriesManager categorie = Provider.of(context).fetch(CategoriesManager);

    manager.inFilter.add("");
    categorie.inFilter.add("");

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: <Widget>[
                Container(
                  child: SizedBox(
                      height: ScreenUtil().setHeight(400),
                      width: ScreenUtil.screenWidth,
                      child: Carousel(
                        images: [
                          ExactAssetImage("images/sadio.jpeg"),
                          NetworkImage(
                              "https://cdn.pixabay.com/photo/2020/01/15/17/38/fireworks-4768501_1280.jpg"),
                          ExactAssetImage(
                            "images/sadio.jpeg",
                          ),
                        ],
                        boxFit: BoxFit.cover,
                      )),
                ),
                Container(
                  height: MediaQuery.of(context).size.height,
                  child: DefaultTabController(
                    length: 6,
                    child: Column(
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: Observer(
                              streams: categorie.browser$,
                              onWaiting: (context) {
                                return TabBar(
                                  isScrollable: true,
                                  indicatorColor: Colors.redAccent,
                                  tabs: [
                                    Tab(
                                      icon: Icon(Icons.home),
                                      text: "Home",
                                    ),
                                    Tab(
                                      icon: Icon(Icons.mic),
                                      text: "Interview",
                                    ),
                                    Tab(
                                      icon: Icon(Icons.videocam),
                                      text: "Reportage",
                                    ),
                                    Tab(
                                      icon: Icon(Icons.directions_run),
                                      text: "Sport",
                                    ),
                                    Tab(
                                      icon: Icon(Icons.show_chart),
                                      text: "Evenement",
                                    ),
                                    Tab(
                                      icon: Icon(Icons.content_paste),
                                      text: "Concours",
                                    )
                                  ],
                                );
                              },
                              onSuccess: (context, data) {
                                List<Categorie> cat = data;

                                return TabBar(
                                  isScrollable: true,
                                  indicatorColor: Colors.redAccent,
                                  tabs: [
                                    Tab(
                                      icon: Icon(Icons.home),
                                      text: "Home",
                                    ),
                                    Tab(
                                        icon: Icon(Icons.mic),
                                        text: utf8convert(
                                          cat[0].nom,
                                        )),
                                    Tab(
                                      icon: Icon(Icons.videocam),
                                      text: utf8convert(
                                        cat[1].nom,
                                      ),
                                    ),
                                    Tab(
                                      icon: Icon(Icons.directions_run),
                                      text: utf8convert(
                                        cat[2].nom,
                                      ),
                                    ),
                                    Tab(
                                        icon: Icon(Icons.show_chart),
                                        text: utf8convert(
                                          cat[3].nom,
                                        )),
                                    Tab(
                                        icon: Icon(Icons.content_paste),
                                        text: utf8convert(
                                          cat[4].nom,
                                        ))
                                  ],
                                );
                              }),
                        ),
                        Expanded(
                          flex: 10,
                          child: Observer(
                            streams: categorie.browser$,
                            onWaiting: (context) {
                              return TabBarView(children: [
                                AcceuilPage(),
                                Container(
                                  margin: EdgeInsets.only(
                                      left: 20, right: 20, top: 20),
                                  height: MediaQuery.of(context).size.height,
                                  //child: CategorieScreen(),
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 20, right: 20),
                                  height: MediaQuery.of(context).size.height,
                                 // child: CategorieScreen(),
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 20, right: 20),
                                  height: MediaQuery.of(context).size.height,
                                  //child: CategorieScreen(),
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 20, right: 20),
                                  height: MediaQuery.of(context).size.height,
                                  //child: CategorieScreen(),
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 20, right: 20),
                                  height: MediaQuery.of(context).size.height,
                                  //child: CategorieScreen(),
                                ),
                              ]);
                            },
                            onSuccess: (context,data){

                              List<Categorie> cat = data;
                              return TabBarView(children: [
                                AcceuilPage(),
                                CategorieScreen(video: cat[0].categorieVideo,),
                                Container(
                                  margin: EdgeInsets.only(left: 20, right: 20),
                                  height: MediaQuery.of(context).size.height,
                                  child: CategorieScreen(video: cat[1].categorieVideo,),
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 20, right: 20),
                                  height: MediaQuery.of(context).size.height,
                                  child: CategorieScreen(video: cat[2].categorieVideo,),
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 20, right: 20),
                                  height: MediaQuery.of(context).size.height,
                                  child: CategorieScreen(video: cat[3].categorieVideo,),
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 20, right: 20),
                                  height: MediaQuery.of(context).size.height,
                                  child: CategorieScreen(video: cat[4].categorieVideo,),
                                ),
                              ]);

                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
