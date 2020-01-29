import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:webtv_app/Models/Video.dart';
import 'package:webtv_app/manager/VideoManager.dart';
import 'package:webtv_app/provider/provider.dart';
import 'package:webtv_app/screen/lectureScreen.dart';
import 'package:webtv_app/widget/videoListBuilder.dart';


class VideoSearchDelegate extends SearchDelegate {

  final VideoManager manager;
  VideoSearchDelegate({this.manager});

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(icon: Icon(Icons.clear), onPressed: (){
        query = '';
      },)
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(icon: Icon(Icons.arrow_back), onPressed: (){
      Navigator.of(context).pop();
    },);
  }

  @override
  Widget buildResults(BuildContext context) {



    if(query.length < 1) {
      return Center(child: Text("your query must contains 1 letters"),);
    }


    VideoManager managers = Provider.of(context).fetch(VideoManager);
    managers.inFilter.add(query);

    return VideoListBuilder(

        stream: manager.browser$,
        // stream: manager.ContactFilter(query: query),
        builder: (context, contact){
          return ListView.separated(
            itemBuilder: (context, index){
              Video _contact = contact[index];
              return ListTile(
                leading: CircleAvatar(),
                title: Text(_contact.titre),
                subtitle: Text(_contact.auteur.username),
              );
            } ,
            itemCount: contact?.length ?? 0,
            separatorBuilder: (context, index) => Divider(),
          );
        }
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    VideoManager managers = Provider.of(context).fetch(VideoManager);

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    managers.inFilter.add(query);
    return VideoListBuilder(
        stream: manager.browser$,
        builder: (context, contact){
          return ListView.separated(
            itemBuilder: (context, index){
              Video _contact = contact[index];
              return  GestureDetector(
                onTap: () =>Navigator.push(context, MaterialPageRoute(
                  builder: (context)=>LectureScreen(url: _contact.video)
                )),
                child: Container(
                  margin: EdgeInsets.only(right: 7, left: 7),
                  decoration:
                  BoxDecoration(border: Border.all(color: Colors.black.withOpacity(.3))),
                  height: height * 0.3,
                  width: width * 0.4,
                  child:  Stack(
                    fit: StackFit.expand,
                    children: <Widget>[
                      Container(
                        child: (_contact.imagePreview != null )? CachedNetworkImage(
                          imageUrl: _contact.imagePreview ,
                        ) : CachedNetworkImage(imageUrl: "http://img.youtube.com/vi/"+_contact.videoUrl.substring(_contact.videoUrl.length - 11)+"/hqdefault.jpg",fit: BoxFit.cover,),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle),
                      ),
                      FractionallySizedBox(
                        heightFactor: 0.4,
                        widthFactor: 0.4,
                        child: Container(
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.black.withOpacity(.7)
                          ),
                          child:  Icon(Icons.play_arrow, size: 35, color: Colors.white,),
                        ),
                      ),
                      Container(
                        alignment: Alignment.bottomCenter,
                        child: FractionallySizedBox(
                          heightFactor: 1/4,
                          widthFactor: 1,
                          child: Container(
                            padding: EdgeInsets.all(10),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(20)),
                                color: Colors.black.withOpacity(.5)
                            ),
                            child:  Text( _contact.titre, style: TextStyle(color: Colors.white, fontSize: 13),),
                          ),
                        ),
                      ),

                    ],

                  )
                ),
              );
            } ,
            itemCount: contact?.length ?? 0,
            separatorBuilder: (context, index) => Divider(),
          );
        }
    );

  }}





class NotificationPage extends StatefulWidget {
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {


    double height=MediaQuery.of(context).size.height;
    double width=MediaQuery.of(context).size.width;

    VideoManager manager = Provider.of(context).fetch(VideoManager);
    manager.inFilter.add("");

    return Scaffold(
      backgroundColor: Colors.black,
        appBar: AppBar(

          title: Center(
            child: GestureDetector(
              onTap: ()=> showSearch(context: context, delegate: VideoSearchDelegate(manager: manager)),
              child: Container(
                //alignment: Alignment.topLeft,
                  height: height*0.06,
                  width: width*0.7,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(40)
                  ),
                  child: Row(
                    //crossAxisAlignment: CrossAxisAlignment.center,
                   // mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(left: 17),
                        alignment: Alignment.centerLeft,

                        width: width*0.5,
                        height: height*0.06,
                        child:  Icon(Icons.search),
                      ),
                    ],
                  )
              ),
            ),
          ),


        ),
    );
  }
}
