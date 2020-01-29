import 'package:rxdart/rxdart.dart';
import 'package:webtv_app/Models/Commentaire.dart';
import 'package:webtv_app/manager/Manager.dart';
import 'package:webtv_app/services/CommentaireService.dart';

class CommentaireManager implements Manager {

  // *****  first

  final PublishSubject<String> _filterSubject = PublishSubject<String>();
  final PublishSubject<List<Commentaire>> _collectionSubject = PublishSubject<List<Commentaire>>();


  Sink<String> get inFilter => _filterSubject.sink;



  // mon getter pour recuperer mon stream
  Stream<List<Commentaire>> get browser$ => _collectionSubject.stream;

  // return une list de Stream
  Stream<List<Commentaire>> userFilter() =>
      Stream.fromFuture(CommentaireService.browser());

  CategoriesManager(){

    _filterSubject
        .debounceTime(Duration(milliseconds: 500))
        .switchMap((filter)async*{
      yield await CommentaireService.browser(query: filter);
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