import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:webtv_app/Models/User.dart';
import 'package:webtv_app/manager/UserManager.dart';
import 'package:webtv_app/manager/UserformManager.dart';
import 'package:webtv_app/provider/provider.dart';
import 'package:webtv_app/widget/Loader.dart';
import 'package:webtv_app/widget/Observer.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>  with AutomaticKeepAliveClientMixin{

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;


  @override
  Widget build(BuildContext context) {

    UserFormManager manager = Provider.of(context).fetch(UserFormManager);

    UserManager user = Provider.of(context).fetch(UserManager);
    user.inFilter.add(manager.name);



    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Container(

              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.height * 0.85,
              child: Observer(
                  streams: user.browser$,
                  onWaiting: (context)=> Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      LoaderWebtv(),
                    ],
                  ),
                  onSuccess: (context , data){
                    List<User> profile = data ;
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          width: 200,
                          height: 130,
                          child: Stack(
                            fit: StackFit.expand,
                            children: <Widget>[
                              FractionallySizedBox(
                                  heightFactor: 0.9,
                                  widthFactor: 0.9,
                                  child: Container(
                                    child: (profile[0].profile.avatar != null )? CachedNetworkImage(
                                      imageUrl: profile[0].profile.avatar,
                                    ) : Image.asset("images/sadio.jpeg",fit: BoxFit.cover,),
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle),
                                  )),

                            ],
                          ),
                        ),
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            myCard("Vues", 235, context),
                            myCard("Abonnés", 475, context),
                            myCard("Abonnement", 1243, context)
                          ],
                        ),
                        SizedBox(height: 40,),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.45,
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              myCard2("Nom :", profile[0].username, context),
                              myCard2("E-mail :", profile[0].email, context),
                              myCard2("Contact :", profile[0].profile.contact, context),
                            ],
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: FlatButton(
                            onPressed: (){
                              manager.closeSession();
                              print("deconnexion");
                            },
                            child: Container(
                              child: Text("deconnexion", style: TextStyle(color: Colors.red, fontSize: 17),),
                            ),
                          ),
                        )
                      ],
                    );

                  }
              ),
            ),
          ),
        ),
      ),
    );
  }

  Card myCard(String lib, int nb, BuildContext context) {
    return Card(
      elevation: 5.0,
      color: Colors.white.withOpacity(.6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 20),
        width: MediaQuery.of(context).size.width * 0.25,
        height: MediaQuery.of(context).size.width * 0.25,
        child: Column(
          children: <Widget>[
            Text(
              lib,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Spacer(),
            Text(
              "${nb}",
              style: TextStyle(
                  fontSize: 25, color: Colors.black, fontWeight: FontWeight.w800),
            )
          ],
        ),
      ),
    );
  }

  Card myCard2(String lib, String value, BuildContext context) {
    return Card(
      color: Colors.white.withOpacity(.6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.080,
        child: Row(
          //mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 25),
              width: MediaQuery.of(context).size.width * 0.4,
              alignment: Alignment.centerLeft,
              child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal, child: Text(lib,style: TextStyle(
                  fontWeight: FontWeight.w800
              ),)),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.4,
              alignment: Alignment.centerLeft,
              child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal, child: Text(value)),
            ),
          ],
        ),
      ),
    );
  }
}

