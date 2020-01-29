import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:webtv_app/Models/Video.dart';
import 'package:webtv_app/manager/VideoManager.dart';
import 'package:webtv_app/provider/provider.dart';
import 'package:webtv_app/screen/ListVideoPage.dart';
import 'package:webtv_app/screen/categorieView.dart';
import 'package:flutter/material.dart';
import 'package:webtv_app/widget/Color.dart';
import 'package:webtv_app/screen/DetailPage.dart';
import 'package:video_player/video_player.dart';
import 'package:webtv_app/widget/Observer.dart';
import 'package:webtv_app/widget/videoListBuilder.dart';

Widget listMenu(
    {BuildContext context,
    String nom}) {

  double height = MediaQuery.of(context).size.height;
  double width = MediaQuery.of(context).size.width;

  VideoManager manager = Provider.of(context).fetch(VideoManager);
  VideoManager nb = Provider.of(context).fetch(VideoManager);
  manager.inFilter.add("");

  return Column(
    
    children: <Widget>[
      SizedBox(
        height: ScreenUtil().setHeight(50),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              RichText(
                  text: TextSpan(
                text: "#",
                style: TextStyle(
                    color: HexColor("#E32E2E"), fontSize: width * .10),
              )),
              RichText(
                  text: TextSpan(
                text: nom,
                style: TextStyle(
                    color: HexColor("#D0CECE"), fontSize: width * .06),
              ))
            ],
          ),
          Row(
            children: <Widget>[
              Observer<int>(
                  streams: nb.count$,
                  onWaiting: (context) => Container(),
                  onSuccess: (context, data) {
                    return RichText(
                        text: TextSpan(
                      text: data.toString() ?? 0,
                      style: TextStyle(
                          color: HexColor("#E32E2E"), fontSize: width * .06),
                    ));
                  }),
              Observer(
                streams: manager.browser$,
                onWaiting: (context)=> Container(),
                onSuccess: (context, data) {
                  List<Video> datas = data;
                  return GestureDetector(
                    onTap: () => Navigator.push(context,
                        MaterialPageRoute(builder: (context) => ListVideoPage(video:datas ,))),
                    child: Container(
                      margin: EdgeInsets.only(right: 10, left: 10),
                      child: Hero(
                        tag: nom,
                        child: Icon(
                          Icons.arrow_forward_ios,
                          color: HexColor("#D0CECE"),
                        ),
                      ),
                    ),
                  );
                }
              )
            ],
          )
        ],
      ),
      SizedBox(
        height: ScreenUtil().setHeight(50),
      ),
      VideoListBuilder(
      stream: manager.browser$,
      builder: (context, data){
        return ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: ScreenUtil().setHeight(200),
          ),
          
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: data?.length ?? 0,
              itemBuilder: (context, i) {

                Video video = data[i];
                return GestureDetector(
                  onTap: () => Navigator.push(
                      context, MaterialPageRoute(builder: (context) => Detail(url: video.video, mesVideo: data,))),
                  child: Container(      
                    width: ScreenUtil().setWidth(400),
                    child:Stack(
                      fit: StackFit.expand,
                      children: <Widget>[
                        Container(
                          height: double.infinity,
                          child: (video.imagePreview!=null)?CachedNetworkImage(imageUrl: video.imagePreview,fit: BoxFit.contain,):CachedNetworkImage(imageUrl: "http://img.youtube.com/vi/"+video.videoUrl.substring(video.videoUrl.length - 11)+"/hqdefault.jpg",fit: BoxFit.fill,),
                        ),
                        FractionallySizedBox(
                          heightFactor: 0.4,
                          widthFactor: 0.4,
                          child: Container(
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white.withOpacity(0.2)
                            ),
                            child:  Icon(Icons.play_arrow, size: 35, color: Colors.white,),
                          ),
                        )
                      ],

                        )


                  ),
                );
              }),
        );
  }
      )
    ],
  );
}


/*

Chewie(
                      controller: checontrole,
                    ),
Stack(
                      fit: StackFit.expand,
                      children: <Widget>[
                        FractionallySizedBox(
                          heightFactor: 0.4,
                          widthFactor: 0.4,
                          child: Container(
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.black.withOpacity(0.4)
                            ),
                            child:  IconButton(
                              onPressed: ()=>Navigator.push(context, MaterialPageRoute(builder: (ctx)=> LectureScreen(url: mesVideo.videoUrl,) )),
                              icon: Icon(Icons.play_arrow, size: 35, color: Colors.white,),
                            ),
                          ),
                        )
                      ],
                    ),
 */