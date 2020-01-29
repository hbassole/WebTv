import 'package:badges/badges.dart';
import 'package:webtv_app/manager/UserManager.dart';
import 'package:webtv_app/manager/UserformManager.dart';
import 'package:webtv_app/manager/VideoManager.dart';
import 'package:webtv_app/screen/DirectPage.dart';
import 'package:webtv_app/screen/HomePage.dart';
import 'package:webtv_app/screen/NotificationPage.dart';
import 'package:webtv_app/screen/UploadPage.dart';
import 'package:webtv_app/screen/login.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:webtv_app/provider/provider.dart';
import 'package:webtv_app/Repository/Overseer.dart';
import 'package:webtv_app/screen/newProfile.dart';
import 'package:webtv_app/screen/profile.dart';
import 'package:flare_splash_screen/flare_splash_screen.dart';

List<CameraDescription> cameras;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  runApp(WebTvApp());
}

class MainPage extends StatefulWidget {

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with SingleTickerProviderStateMixin{

  TabController controller;
  @override
  void initState() {
    super.initState();
    controller = new TabController(length: 5, vsync: this,initialIndex: 2);
  }
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {

    double height=MediaQuery.of(context).size.height;
    double width=MediaQuery.of(context).size.width;

    VideoManager managerSearch = Provider.of(context).fetch(VideoManager);
    managerSearch.inFilter.add("");


    UserFormManager manager = Provider.of(context).fetch(UserFormManager);
    UserManager user = Provider.of(context).fetch(UserManager);
    user.inFilter.add(manager.name);

    print(manager.name);

    return Scaffold(
      body: TabBarView(
        children: <Widget>[
          DirectPage(),
          UploadPage(),
          HomePage(),
          NotificationPage(),
          StreamBuilder(
            stream: manager.isSessionValid,
            builder: (context, snpashot){
              if(snpashot.data == true){
                print("connnect");
                return Profile();
              }else{
                //print("disconnnect");
                return LoginScreen();
              }
            },)
        ],
        controller: controller,
      ),
      bottomNavigationBar: new Material(
        color: Colors.black,
        shadowColor: Colors.white,
        child: new TabBar(
          indicator: UnderlineTabIndicator(
            borderSide: BorderSide(color: Colors.red, width: 5.0),
            insets: EdgeInsets.fromLTRB(width*0.02, 0.0, width*0.02, 67.0),
          ),
          tabs: [
            new Tab(
                icon: new Icon(
                  Icons.live_tv,
                  size: 30.0,
                  color: Colors.white,
                )
            ),
            new Tab(
              icon: new Icon(
                Icons.camera,
                size: 30.0,
                color: Colors.white,
              ),
            ),
            CircleAvatar(
              radius: 40,
              backgroundColor: Colors.red,
              child: Tab(
                icon: new Icon(
                  Icons.home,
                  size: 40.0,
                  color: Colors.white,
                ),
              ),),
            new Tab(
              icon: IconButton(
                icon: Icon(
                  Icons.search,
                  size: 30.0,
                  color: Colors.white,
                ),
              ),
            ),
            CircleAvatar(
              backgroundColor: Colors.white,
              child: new Tab(
                icon: new Icon(
                  Icons.person,
                  size: 30.0,
                  color: Colors.black,
                ),
              ),
            ),
          ],
          controller: controller,
        ),
      ),


    );
  }
}



class WebTvApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    return Provider(
      data: Overseer(),
      child: MaterialApp(
        title: 'WebTv App with Stream',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          primaryColor: Colors.black,
        ),
        debugShowCheckedModeBanner: false,
        home:  Builder(
          //add builder here to have a context where navigator is available
          builder: (context) => SplashScreen.callback(
            name: 'images/Splashscreen-WebTV.flr',
            onSuccess: (_) {
              Navigator.of(context).pushReplacement(PageRouteBuilder(
                  pageBuilder: (_, __, ___) =>
                      MainPage()));
            },
            loopAnimation: 'logo',
            until: () => Future.delayed(Duration(seconds: 3)),
            //endAnimation: 'wait',
            onError: (error, stacktrace) {
              print(error);
            },
          ),
        ),
      )
    );
  }
}



