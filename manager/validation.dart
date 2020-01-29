import 'dart:async';

mixin Validation {

  final validateUsername  = StreamTransformer<String, String>.fromHandlers(
      handleData: (String value, EventSink<String> sink){

        int len = value.length;
        if(len == 0){
          return sink.addError("le champs ne doit pas etre vide");
        }else if(len < 4 ){
          return sink.addError("plus de 4 lettre");
        }else{
          return sink.add(value);
        }
      }
  );

  final validatePassword = StreamTransformer<String, String>.fromHandlers(
      handleData: (String value, EventSink<String> sink){

        int len = value.length;
        if(len == 0){
          return sink.addError("le champs ne doit pas etre vide");
        }else if(len < 4 ){
          return sink.addError("plus de 4 lettre");
        }else{
          return sink.add(value);
        }
      }
  );



}
