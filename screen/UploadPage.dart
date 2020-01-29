
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:webtv_app/services/VideoService.dart';

List<CameraDescription> cameras;
class UploadPage extends StatefulWidget {
  @override
  _UploadPageState createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {
  File _video;
  File _cameraVideo;
  String lien;
  TextEditingController descriptionController =TextEditingController();
  VideoPlayer deo;

  VideoPlayerController _videoPlayerController;
  VideoPlayerController _cameraVideoPlayerController;


  // This funcion will helps you to pick a Video File
  _pickVideo() async {
    File video = await ImagePicker.pickVideo(source: ImageSource.gallery);
    _video = video;
    lien=_video.path.replaceAll(".MOV", ".mp4");
    print("+++++++++++++++++++++++++++++++");
    print(_video.path);
    _videoPlayerController = VideoPlayerController.file(_video)..initialize().then((_) {
      setState(() { });
      _videoPlayerController.play();
    });

  }

  // This funcion will helps you to pick a Video File from Camera
  _pickVideoFromCamera() async {
    File video = await ImagePicker.pickVideo(source: ImageSource.camera);
    _cameraVideo = video;
    lien=_cameraVideo.path.replaceAll(".MOV", ".mp4");
    print("------------------------");
    print(_cameraVideo.path);
    _cameraVideoPlayerController = VideoPlayerController.file(_cameraVideo)..initialize().then((_) {
      setState(() { });
      _cameraVideoPlayerController.play();
    });

  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return (_video == null && _cameraVideo==null)

        ? Container(
      color: Colors.black,
          child: Column(
      children: <Widget>[
          Expanded(
            flex: 2,
            child: Padding(
              padding: EdgeInsets.all(40),
                child: Image.asset("images/logo_awt.png")),
          ),
          Expanded(
            flex: 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                IconButton(icon: Icon(Icons.camera_alt,size: 50,color: Colors.white,), onPressed:()=> _pickVideoFromCamera()),
                IconButton(icon: Icon(Icons.image,size: 50,color: Colors.white,), onPressed:()=> _pickVideo())
              ],
            ),
          )
      ],
    ),
        )
        : Scaffold(
      backgroundColor: Colors.black,
        resizeToAvoidBottomPadding: false,
        body: GestureDetector(
          onTap: (){
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: Stack(
            children: <Widget>[
              if(_video!=null)
                Center(
                child: AspectRatio(
                  aspectRatio: _videoPlayerController.value.aspectRatio,
                  child: VideoPlayer(_videoPlayerController),
                ),
              ),
              if(_cameraVideo!=null)
                Center(
                  child: AspectRatio(
                    aspectRatio: _cameraVideoPlayerController.value.aspectRatio,
                    child: VideoPlayer(_cameraVideoPlayerController),
                  ),
                ),

              (_video!=null || _cameraVideo!=null )?Positioned(
                top: 20,
                left: 20,
                child: IconButton(
                    icon: Icon(Icons.close,color: Colors.white,size: 35,),
                    onPressed: clearImage)
              ):Container(),
              (_video!=null || _cameraVideo!=null)?Column(
              children: <Widget>[
                Spacer(),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10))
                  ),
                  child: Row(
                    children: <Widget>[
                      new Flexible(
                        child: new ConstrainedBox(
                          constraints: new BoxConstraints(
                            minWidth: width,
                            maxWidth: width,
                            minHeight: 25.0,
                            maxHeight: 135.0,
                          ),
                          child: new Scrollbar(
                            child: new TextField(
                              
                              onSubmitted: null,
                              cursorColor: Colors.red,
                              maxLines: null,
                              controller: descriptionController,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.only(
                                    top: 2.0,
                                    left: 13.0,
                                    right: 13.0,
                                    bottom: 2.0),
                                hintText: "Ajouter une description",
                                hintStyle: TextStyle(
                                  color:Colors.grey,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      new Container(
                        margin: new EdgeInsets.symmetric(horizontal: 4.0),
                        child: new IconButton(
                          icon: new Icon(Icons.send,color:Colors.red,),
                          onPressed:()async{
                            
                             /*  var postv= await VideoService.postVideo(id_user: 1,nameFile: lien,titleVideo: descriptionController.text);
                              print(postv); */
                            
                          },
                        ),
                      ),
                    ],
                  ),
                )
              ],

              ):Container(),
            ],
          ),
        ));

  }
  void clearImage() {
    setState(() {
      _video = null;
      _cameraVideo=null;
    });

  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _videoPlayerController.dispose();
    _cameraVideoPlayerController.dispose();
  }



}
