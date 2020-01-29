import 'package:webtv_app/screen/categorieView.dart';
import 'package:webtv_app/widget/Color.dart';
import 'package:flutter/material.dart';

List<Icon> listIcon = [
  Icon(
    Icons.calendar_today,
    color: Colors.white,
  ),
  Icon(
    Icons.mic,
    color: HexColor("#D0CECE"),
  ),
  Icon(
    Icons.videocam,
    color: HexColor("#D0CECE"),
  ),
  Icon(
    Icons.directions_run,
    color: HexColor("#D0CECE"),
  ),
  Icon(
    Icons.show_chart,
    color: HexColor("#D0CECE"),
  )
];
List<String> listcate = [
  "AGENDA",
  "INTERVIEW",
  "REPORTAGE",
  "SPORT",
  "EVEMENTS"
];
List<Widget> route = [
  CategorieScreen(),
  CategorieScreen(),
  CategorieScreen(),
  CategorieScreen(),
  CategorieScreen(),
];

Widget drawer({BuildContext context}) {
  double height = MediaQuery.of(context).size.height;
  double width = MediaQuery.of(context).size.width;
  return Container(
    width: width / 1.5,
    decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(40),
        )),
    child: Column(
      children: <Widget>[
        Container(
            margin: EdgeInsets.only(top: 50),
            child: Text(
              "MENU",
              style: TextStyle(color: Colors.red, fontSize: width * 0.08),
            )),
        Container(
          alignment: Alignment.topCenter,
          width: width / 1.5,
          height: height / 2,
          child: ListView.builder(
            itemCount: listcate.length,
            itemBuilder: (context, i) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => route[i]));
                },
                child: Container(
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.red)),
                  child: ListTile(
                    leading: listIcon[i],
                    title: Text(
                      listcate[i],
                      style: TextStyle(color: HexColor("#D0CECE")),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        Spacer(),
        Container(child: Image.asset("images/logo_awt.png"))
      ],
    ),
  );
}
