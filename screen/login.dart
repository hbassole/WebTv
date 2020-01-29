import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:webtv_app/manager/UserformManager.dart';
import 'package:webtv_app/provider/provider.dart';

class LoginScreen extends StatefulWidget {
  static const urlName = "Login";

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool submit = false;

  @override
  Widget build(BuildContext context) {
    double height=MediaQuery.of(context).size.height;
    double width=MediaQuery.of(context).size.width;

    ScreenUtil.init(context,width:750,height:1334,allowFontScaling:false);

    UserFormManager manager = Provider.of(context).fetch(UserFormManager);
    manager.restoreSession();


    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Container(
         
          
          child: Column(

            children: <Widget>[
              Container(
                height: ScreenUtil().setHeight(200),
                margin: EdgeInsets.symmetric(horizontal: 25, vertical: 50),
                decoration: BoxDecoration(
                    image: DecorationImage(image: ExactAssetImage('images/logo_awt.png'))
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Container(
                margin: EdgeInsets.only(left: 20,right: 20),
                child: Column(
                    children: <Widget>[
                      Text("Connexion", style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w700,color: Colors.white
                      ),),
                      SizedBox( height: 40,),
                      StreamBuilder<Object>(
                        stream: manager.username$,
                        builder: (context, snapshot){
                          return TextField(
                            style: TextStyle(color: Colors.white),
                            onChanged: manager.inUsername.add,
                             cursorColor: Colors.white,
                            decoration: InputDecoration(
                                hintText: "Username",
                                hintStyle: TextStyle(color: Colors.white),
                                enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                                focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                                
                                prefixIcon: Icon(Icons.person,color: Colors.white,),
                                errorText: snapshot.error
                            ),
                          );

                        },
                      ),
                      SizedBox( height: 20,),
                      StreamBuilder<Object>(
                        stream: manager.password$,
                        builder: (context, snapshot){
                          return TextField(
                            style: TextStyle(color: Colors.white),
                            onChanged: manager.inPassword.add,
                            obscureText: true,
                            cursorColor: Colors.white,
                            decoration: InputDecoration(
                              focusColor: Colors.white,
                              fillColor: Colors.white,
                              hintText: "password",
                              hintStyle: TextStyle(color: Colors.white),
                              enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                                focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                              prefixIcon: Icon(Icons.security,color: Colors.white,),
                              errorText: snapshot.error,

                            ),
                          );

                        },
                      ),
                      SizedBox(height: 25,),
                      SizedBox( height: 40,),
                      StreamBuilder<Object>(
                        stream: manager.isFormValide$,
                        builder: (context, snapshot){
                          if(snapshot.hasData){
                            return InkWell(
                              onTap: (){
                                print('ok');
                                manager.submit();
                                var ok = manager.submit();
                                print(ok);
                                setState(() {
                                  submit = true;
                                });
                              },
                              //onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (context)=> ProfileScreen())),
                              child: (submit)? CircularProgressIndicator(): Container(
                                height: MediaQuery.of(context).size.height * 0.06,
                                width: MediaQuery.of(context).size.width * 0.4,
                                child: Center(
                                    child: Text('Se connecter', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 18),)
                                ),
                                decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(15)
                                ),
                              ),
                            );

                          }else{

                            return Container(
                              height: MediaQuery.of(context).size.height * 0.06,
                              width: MediaQuery.of(context).size.width * 0.4,
                              child: Center(
                                  child: Text('Se connecter', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 18),)
                              ),
                              decoration: BoxDecoration(
                                  color: Colors.red.withOpacity(.5),
                                  borderRadius: BorderRadius.circular(15)
                              ),
                            );

                          }
                        },
                      ),
                     SizedBox( height: 40,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text("Pas de compte ?",style:TextStyle(color: Colors.white),),
                          SizedBox(width: 10),
                          InkWell(child: Text("S'inscrire à partir du site web", style: TextStyle(color: Colors.red, fontWeight: FontWeight.w500),),
                          ),
                        ],
                      )
                    ],
                  ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}