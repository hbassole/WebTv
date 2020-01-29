import 'package:webtv_app/screen/DetailPage.dart';
import 'package:flutter/material.dart';
class RecentPage extends StatefulWidget {
  @override
  _RecentPageState createState() => _RecentPageState();
}

class _RecentPageState extends State<RecentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 20,
          ),
          Hero(
            tag: "Recent",
            child: Container(

                child: IconButton(icon: Icon(Icons.keyboard_arrow_down,size: 40,),onPressed: ()=>Navigator.pop(context),)),
          ),
          Expanded(
              flex: 10,
              child:GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,mainAxisSpacing: 20, crossAxisSpacing:10, childAspectRatio: 2/3),
                itemCount: 5,
                itemBuilder: (context, i){
                  return GridTile(
                    footer: Container(
                      height: 50,
                      color: Colors.black87,
                      child: Center(child: Text(" testetstetst",style: TextStyle(
                          color: Colors.white, fontSize: 12
                      ),)),
                    ),
                    child: InkWell(
                      child: Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: ExactAssetImage("images/sadio.jpeg")
                            ),
                            borderRadius: BorderRadius.circular(15)
                        ),
                        child: Stack(
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
                                  onPressed: ()=>Navigator.push(context, MaterialPageRoute(builder: (ctx)=> Detail() )),
                                  icon: Icon(Icons.play_arrow, size: 35, color: Colors.white,),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ))
        ],
      ),
    );
  }
}
