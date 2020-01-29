import 'package:rxdart/rxdart.dart';
import 'package:webtv_app/Models/Direct.dart';
import 'package:webtv_app/manager/Manager.dart';
import 'package:webtv_app/services/DirectService.dart';

class DirectManager implements Manager {

  // *****  first

  final PublishSubject<String> _filterSubject = PublishSubject<String>();
  final PublishSubject<List<Direct>> _collectionSubject = PublishSubject<List<Direct>>();


  Sink<String> get inFilter => _filterSubject.sink;

  // mon getter pour recuperer mon stream
  Stream<List<Direct>> get browser$ => _collectionSubject.stream;

  // return une list de Stream
  Stream<List<Direct>> userFilter({query}) =>
      Stream.fromFuture(DirectService.browser(query: query));

  DirectManager(){

    _filterSubject
        .debounceTime(Duration(milliseconds: 500))
        .switchMap((filter)async*{
      yield await DirectService.browser(query: filter);
    })
        .listen((contact) async{
      _collectionSubject.add(contact);
    });

  }
/*
  void dispose(){
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
  var ok = DirectManager().userFilter(query: "");
  // with stream.....
  ok.listen((x)=> print(x.map((x) => x.titre)));

}


 */
