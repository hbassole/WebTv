import 'package:flutter/material.dart';
import 'package:webtv_app/services/VideoService.dart';
import 'package:webtv_app/widget/ChatMessage.dart';


class CommentPage extends StatefulWidget {
  List<dynamic> comment;
  String username;
  int id;
  String slug ;

  CommentPage({this.comment, this.username, this.id, this.slug});
  @override
  State<StatefulWidget> createState() {
    return CommentPageState();
  } //new
}
// Add the ChatScreenState class definition in main.dart.
class CommentPageState extends State<CommentPage> with TickerProviderStateMixin {

  final List<ChatMessage> messages = <ChatMessage>[];

  final TextEditingController _textController = new TextEditingController();

  bool _isComposing = false;
  String name;

  @override
  void initState() {

    super.initState();
    for(var i = 0; i < widget.comment.length; i++){
      ChatMessage ok = ChatMessage(text : widget.comment[i]["message"],animationController: AnimationController(
        duration: new Duration(milliseconds: 700), //new
        vsync: this, //new
      ), username: widget.username,);
      setState(() {
        messages.insert(0, ok);
      });
      ok.animationController.forward();
    }
  }


  void _handleSubmitted(String text)async{
    setState(() {
      _isComposing = false;
    });

    var comment = await VideoService.commentVideo(id_user: widget.id, slug: widget.slug, messages: text );
    print(comment);

    _textController.clear();
    ChatMessage message = new ChatMessage(
      text: text,
      animationController: new AnimationController(
        //new
        duration: new Duration(milliseconds: 700), //new
        vsync: this, //new
      ),
      username: widget.username,//new
    ); //new
    setState(() {
      messages.insert(0, message);
    });

    message.animationController.forward(); //new

  }
  @override
  void dispose() {
    for (ChatMessage message in messages) //new
      message.animationController.dispose(); //new
    super.dispose(); //new
  } //new
  @override //new
  Widget build(BuildContext context) {

    return new Scaffold(
      backgroundColor: Colors.black,
      appBar: new AppBar(title: new Text("commentaire")),
      body: new Column(
        children: <Widget>[
          new Flexible(
            child: new ListView.builder(
              padding: new EdgeInsets.all(8.0), //new
              reverse: true, //new
              itemBuilder: (context, int index) {
                return messages[index];
              }, //new
              itemCount: messages.length, //new
            ), //new
          ), //new
          new Divider(height: 1.0), //new
          new Container(
            decoration:
            new BoxDecoration(color: Theme.of(context).cardColor), //new
            child: _buildTextComposer(), //modified
          ), //new
        ], //new
      ), //new
    );
  }
  Widget _buildTextComposer() {
    return new IconTheme(
      data: new IconThemeData(color: Theme.of(context).accentColor), //new
      child: new Container(
        //modified
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        child: new Row(
          children: <Widget>[
            new Flexible(
              child: Container(
                child: new TextField(
                  controller: _textController,
                  onChanged: (String text) {
                    setState(() {
                      _isComposing = text.length > 0; //new
                    }); //new
                  },
                  onSubmitted: _handleSubmitted,
                  decoration:
                  new InputDecoration.collapsed(hintText: "envoie de message"),
                ),
                padding: EdgeInsets.all(5),
              ),
            ),
            new Container(
              margin: new EdgeInsets.symmetric(horizontal: 4.0),
              child: new IconButton(
                icon: new Icon(Icons.send),
                onPressed: _isComposing
                    ? () => _handleSubmitted(_textController.text) //modified
                    : null,
              ),
            ),
          ],
        ),
      ), //new
    );
  }
}