import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:webtv_app/Models/Vue.dart';
import 'package:webtv_app/manager/Manager.dart';
import 'package:webtv_app/services/VueService.dart';

class VueManager implements Manager {

  // *****  first

  final PublishSubject<String> _filterSubject = PublishSubject<String>();
  final PublishSubject<List<Vue>> _collectionSubject = PublishSubject<List<Vue>>();


  Sink<String> get inFilter => _filterSubject.sink;



  // mon getter pour recuperer mon stream
  Stream<List<Vue>> get browser$ => _collectionSubject.stream;

  // return une list de Stream
  Stream<List<Vue>> userFilter({query}) =>
      Stream.fromFuture(VueService.browser(query: query));

  VueManager(){

    _filterSubject
        .debounceTime(Duration(milliseconds: 500))
        .switchMap((filter)async*{
      yield await VueService.browser(query: filter);
    })
        .listen((contact) async{
      _collectionSubject.add(contact);
    });

  }

  /*void dispose(){
    _filterSubject.close();
  }


   */

  @override
  void dispose() {
    // TODO: implement dispose
  }
}

/*
void main(){
  var ok = VueManager().userFilter(query: "");
  // with stream.....
  ok.listen((x)=> print(x.map((x) => x.ip)));

}

 */
