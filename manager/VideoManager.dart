import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:webtv_app/Models/Video.dart';
import 'package:webtv_app/manager/Manager.dart';
import 'package:webtv_app/services/VideoService.dart';

class VideoManager implements Manager {

  // *****  first

  final PublishSubject<String> _filterSubject = PublishSubject<String>();
  final PublishSubject<List<Video>> _collectionSubject = PublishSubject<List<Video>>();

  final BehaviorSubject<int> _controllerCount = BehaviorSubject<int>();
  Stream<int> get count$ => _controllerCount.stream;


  Sink<String> get inFilter => _filterSubject.sink;

  // mon getter pour recuperer mon stream
  Stream<List<Video>> get browser$ => _collectionSubject.stream;



  VideoManager(){

    _filterSubject
        .debounceTime(Duration(milliseconds: 500))
        .switchMap((filter)async*{
      yield await VideoService.browser(query: filter);
    })
        .listen((contact) async{
      _collectionSubject.add(contact);
    });

    _collectionSubject.listen((list)=> _controllerCount.add(list.length));
  }


  @override
  void dispose() {
    // TODO: implement dispose
    _filterSubject.close();
    _controllerCount.close();
  }

}

/*
void main(){
  var ok = VideoManager().userFilter(query: "");
  // with stream.....
  ok.listen((x)=> print(x.map((x) => x.titre)));

}

 */