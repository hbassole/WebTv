import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';
import 'package:webtv_app/Models/Categorie.dart';
import 'package:webtv_app/manager/Manager.dart';
import 'package:webtv_app/services/CategorieService.dart';

class CategoriesManager implements Manager{

  // *****  first

  final PublishSubject<String> _filterSubject = PublishSubject<String>();
  final PublishSubject<List<Categorie>> _collectionSubject = PublishSubject<List<Categorie>>();


  Sink<String> get inFilter => _filterSubject.sink;

  // mon getter pour recuperer mon stream
  Stream<List<Categorie>> get browser$ => _collectionSubject.stream;


  CategoriesManager(){
    _filterSubject
        .debounceTime(Duration(milliseconds: 500))
        .switchMap((filter)async*{
          yield await CategoriesService.browser(query: filter);
    })
    .listen((contact) async{
      _collectionSubject.add(contact);
    });

  }

  @override
  void dispose() {
    // TODO: implement dispose
  }



}

/*
void main(){
  var ok = CategoriesManager().userFilter(query: "");
  // with stream.....
  ok.listen((x)=> print(x.map((x) => x.nom)));

}

 */