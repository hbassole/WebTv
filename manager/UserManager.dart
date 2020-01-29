import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:webtv_app/Models/User.dart';
import 'package:webtv_app/manager/Manager.dart';
import 'package:webtv_app/services/UserService.dart';

class UserManager implements Manager {

  // *****  first

  final PublishSubject<String> _filterSubject = PublishSubject<String>();
  final PublishSubject<List<User>> _collectionSubject = PublishSubject<List<User>>();


  Sink<String> get inFilter => _filterSubject.sink;



  // mon getter pour recuperer mon stream
  Stream<List<User>> get browser$ => _collectionSubject.stream;


  UserManager(){

    _filterSubject
        .debounceTime(Duration(milliseconds: 500))
        .switchMap((filter)async*{
      yield await UserService.browser(query: filter);
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
  var ok = UserManager().userFilter(query: "");
  // with stream.....
  ok.listen((x)=> print(x.map((x) => x.email)));

}

 */