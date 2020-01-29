import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webtv_app/widget/Color.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:webtv_app/Models/User.dart';
import 'package:webtv_app/manager/UserManager.dart';
import 'package:webtv_app/manager/UserformManager.dart';
import 'package:webtv_app/provider/provider.dart';
import 'package:webtv_app/widget/Loader.dart';
import 'package:webtv_app/widget/Observer.dart';
import 'package:cached_network_image/cached_network_image.dart';


class Profile extends StatefulWidget {

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> with AutomaticKeepAliveClientMixin{



  String name = "";
  String email = "";
  String contact = "";
  String avatar = "";
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getName();
  }

    Stream<int> stream = Stream.periodic(Duration(milliseconds: 100), (value)=> value+=1).asBroadcastStream();


  getName()async{

      SharedPreferences shared_User = await SharedPreferences.getInstance();
    setState(() {
      name = shared_User.getString('username');
      avatar = shared_User.getString('avatar');
      email = shared_User.getString('email');
      contact = shared_User.getString('contact');
    });

  }

  @override
  Widget build(BuildContext context) {

    UserFormManager manager = Provider.of(context).fetch(UserFormManager);
    UserManager user = Provider.of(context).fetch(UserManager);
    ScreenUtil.init(context,width:750,height:1334,allowFontScaling:false);
    user.inFilter.add(manager.name);


   Future _alertdialog(BuildContext context){
    return showDialog(
         context: context,
      builder: (BuildContext context){
           return AlertDialog(
             title: Text("Deconnexion ?"),
             content: Text("voulez vous , vous deconnectez ?"),
             actions: <Widget>[
               FlatButton(
                   onPressed:(){
                     Navigator.of(context).pop();
                   } ,
                   child: Text("NON")),
               FlatButton(onPressed: (){
                 manager.closeSession();
                 Navigator.of(context).pop();
               },
                   child: Text("OUI"))
             ],

           );
      }
     );


   }


    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.black,
        title: Column(
          children: <Widget>[
            Text(
              "Profile",
              style: TextStyle(
                color: HexColor("#D0CECE"),
              ),
            ),
            Icon(Icons.person_outline,size: 25,color: Colors.red,)
          ],
        ),
      ),
      body: Column(
        children: <Widget>[
          Flexible(
            fit: FlexFit.loose,
            child:
            Container(
              //padding: EdgeInsets.all(2),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[

                  Flexible(
                    fit: FlexFit.loose,
                    child: Container(
                      margin: EdgeInsets.only(left: 20,right: 20),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      CircleAvatar(
                        radius: ScreenUtil().setHeight(100),
                        backgroundColor: Colors.grey,
                        child: Observer(
                            streams: user.browser$,
                            onSuccess: (context, data) {
                              List<User> datas = data;
                              return CircleAvatar(
                                backgroundImage:NetworkImage(datas[0].profile.avatar) ,
                                radius: ScreenUtil().setHeight(100),
                                backgroundColor: Colors.grey);
                            }
                        ),
                      ),
                      SizedBox(
                        width: ScreenUtil().setWidth(10),
                      ),
                      Flexible(
                        flex: 1,
                        fit: FlexFit.loose,
                        child: Container(
                          child:
                          Column(
                            children: <Widget>[
                              RichText(
                                text: new TextSpan(
                                  text: name,
                                  style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white, fontSize: 18),
                                  children: <TextSpan>[
                                    TextSpan(text: '\n',style: new TextStyle(fontWeight: FontWeight.bold)),
                                    TextSpan(text: email,style: new TextStyle(fontWeight: FontWeight.normal ,fontSize: 13 , color: Colors.grey)),
                                    TextSpan(text: '\n',style: new TextStyle(fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              ),
                              Row(
                                children: <Widget>[
                                  Flexible(child: Container(
                                      alignment: Alignment.center,
                                    height: 40,decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(20)),
                                    color: Colors.grey,
                                  ),child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Icon(Icons.person,color: Colors.red.withOpacity(0.7),),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text("journaliste",style: new TextStyle(fontWeight: FontWeight.normal ,fontSize: 13 , color: Colors.red) ),
                                    ],
                                  ), ),),
                                  SizedBox(width: 5,),
                                  Flexible(child: GestureDetector(
                                    onTap: (){
                                        _alertdialog(context);
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      height: 40, decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(Radius.circular(20)),
                                      color: Colors.red,
                                    ),child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        Icon(Icons.subdirectory_arrow_left,color: Colors.white,),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text("deconnection",style: new TextStyle(fontWeight: FontWeight.normal ,fontSize: 13 , color: Colors.white, ),)
                                      ],
                                    ),),
                                  ))
                                ],
                              )

                            ],
                          ),
                        ),
                      ),
                    ],
                  ),),),
                  Flexible(
                    fit: FlexFit.loose,
                    child: Container(
                      height: ScreenUtil().setHeight(120),
                      child: Row(

                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Observer(
                                  streams: user.browser$,
                                  onWaiting: (context){
                                    return StreamBuilder(
                                      initialData: 0,
                                      stream: stream,
                                      builder: (context, data){
                                        return Text(data.data.toString(),style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold));
                                      },
                                    );
                                  },
                                  onSuccess: (context, data) {
                                    List<User> datas = data;
                                    return Text(datas[0].userVideo.length.toString(),style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold));
                                  }
                              ),
                              Text("Post",style: new TextStyle(fontWeight: FontWeight.bold ,fontSize: 13 , color: Colors.black))
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Observer(
                                  streams: user.browser$,
                                  onWaiting: (context){
                                    return StreamBuilder(
                                      initialData: 0,
                                      stream: stream,
                                      builder: (context, data){
                                        return Text(data.data.toString(),style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold));
                                      },
                                    );
                                  },
                                  onSuccess: (context, data) {
                                    List<User> datas = data;
                                    return Text(datas[0].directvideo.length.toString(),style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold));
                                  }
                              ),
                              Text("Direct",style: new TextStyle(fontWeight: FontWeight.bold ,fontSize: 13 , color: Colors.black))
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Observer(
                                  streams: user.browser$,
                                  onWaiting: (context){
                                    return StreamBuilder(
                                      initialData: 0,
                                      stream: stream,
                                      builder: (context, data){
                                        return Text(data.data.toString(),style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold));
                                      },
                                    );
                                  },
                                  onSuccess: (context, data) {
                                    List<User> datas = data;
                                    return Text(datas[0].vues.length.toString(),style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold),);
                                  }
                              ),
                              Text("Vues",style: new TextStyle(fontWeight: FontWeight.bold ,fontSize: 13 , color: Colors.black))
                            ],
                          ),

                        ],
                      ),
                      decoration: BoxDecoration(
                         // border: Border.all(color: Colors.red),
                      color: Colors.grey,
                      borderRadius: BorderRadius.all(Radius.circular(20))
                  ),),),

                ],
              ),
              height: ScreenUtil().setHeight(600),
              decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(40),
                    bottomRight: Radius.circular(40),

                  )
              ),


          ),),
          Flexible(
            fit: FlexFit.loose,
            child: Container(

              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: ScreenUtil().setHeight(80),
                  ),
                  Flexible(
                    flex: 1,
                    child:
                    Container(
                      margin: EdgeInsets.only(left: 20,right: 20,bottom: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text("Mes Videos",style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold,color: Colors.white),),
                          Icon(Icons.arrow_forward_ios,color: Colors.white,),
                        ],
                      )
                    ),),
                  Flexible(
                    flex: 3,
                    child: Container(
                      height: ScreenUtil().setHeight(200),
                      child: Observer(
                          streams: user.browser$,
                          onSuccess: (context, data) {
                            List<User> datas = data;
                            return ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: datas[0]?.userVideo.length,
                              itemBuilder: (context,i){
                                return ConstrainedBox(

                                  constraints: BoxConstraints(
                                    minHeight: ScreenUtil().setHeight(200),
                                    maxWidth: ScreenUtil().setWidth(400),
                                  ),
                                      child: Container(
                                      
                                      decoration: BoxDecoration(
                                        image: DecorationImage(

                                          image: (datas[0].userVideo[i].imageUrl!= null )? CachedNetworkImageProvider(
                                            datas[0].userVideo[i].imageUrl,
                                          ) : CachedNetworkImageProvider("http://img.youtube.com/vi/"+datas[0].userVideo[i].videoUrl.substring(datas[0].userVideo[i].videoUrl.length - 11)+"/hqdefault.jpg",)
                                        ),
                                        borderRadius: BorderRadius.all(Radius.circular(20)),
                                        //color: Colors.grey,
                                      ),
                                  ),
                                );
                              },

                            );
                          }
                      ),
                    ),),
                  

                ],
              ),

            ),
          ),

        ],
      ),
    );
  }
}
