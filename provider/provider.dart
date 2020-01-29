import 'package:flutter/material.dart';
import 'package:webtv_app/Repository/overseer.dart';

class Provider extends InheritedWidget {

// Data who listen Stream
  // final ContactManager data;
  final  data;


  Provider({Key key, Widget child, this.data}):super(key : key, child : child);

// how to access to data?
  static of(BuildContext context){
    // final type = _typeOf<Provider<T>>();
    return context.dependOnInheritedWidgetOfExactType<Provider>().data;
  }

  // static Type _typeOf<T>() => T ;

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return false;
  }

}