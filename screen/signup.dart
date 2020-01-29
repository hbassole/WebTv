import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'login.dart';


class SignupScreen extends StatelessWidget {
  static const urlName = "Signup";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
              child: SafeArea(
                child: Container(
            height: ScreenUtil().setHeight(1334),
            width: ScreenUtil().setWidth(750),
            child: Stack(
              fit: StackFit.expand,
              children: <Widget>[
                FractionallySizedBox(
                  heightFactor: 0.25,
                  alignment: Alignment.topCenter,
                  child: Container(
                    color: Colors.white,
                  )
                ),
                FractionallySizedBox(
                  alignment: Alignment.bottomCenter,
                  heightFactor: 0.75,
                  child: Container(
                    margin: EdgeInsets.only(left: 30, right: 30, bottom: 70, top: 30),
                    padding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(40)
                    ),
                    child: SingleChildScrollView(
                                        child: Column(
                        children: <Widget>[
                          Text("Connexion", style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w700
                          ),),
                          SizedBox( height: 25,),
                          TextField(
                            decoration: InputDecoration(
                              hintText: "E-mail",
                              
                            ),
                          ), 
                          SizedBox( height: 25,),
                          TextField(
                            decoration: InputDecoration(
                              hintText: "Mot de passe",
                              suffixIcon: IconButton(
                                icon: Icon(Icons.remove_red_eye),
                              )
                            ),
                          ),
                          SizedBox(height: 25,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              SizedBox(width: 30,),
                              InkWell(
                                child: Text("Mot de passe oublié ?",
                                 style: TextStyle(color: Colors.red, fontWeight: FontWeight.w600)),
                              ),
                            ],
                          ),
                          SizedBox(height: 25,),
                          InkWell(
                            onTap: (){},
                              child: Container(
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
                          ),
                          SizedBox(height: 30),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text("Deja un compte ?"),
                              SizedBox(width: 10),
                              InkWell(child: Text("S'inscrire", style: TextStyle(color: Colors.red, fontWeight: FontWeight.w500),),
                               onTap: ()=> Navigator.pushReplacementNamed(context, LoginScreen.urlName)
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}