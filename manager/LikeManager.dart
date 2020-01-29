import 'package:rxdart/rxdart.dart';
import 'package:webtv_app/manager/Manager.dart';


class LikeManager implements Manager {

  BehaviorSubject<int> _controlCounter = BehaviorSubject<int>();

  Sink<int> get inFilter => _controlCounter.sink;


  int get _current => _controlCounter.value;

  Stream<int> get counter$ => _controlCounter.stream;

  void increment() => _controlCounter.add(_current + 1);
  void decrement() => _controlCounter.add(_current - 1);
  @override
  void dispose() {
    _controlCounter.close();
    // TODO: implement dispose
  }

}