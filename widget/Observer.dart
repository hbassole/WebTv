import 'package:flutter/material.dart';

class Observer<T> extends StatelessWidget {

  @required
  final Function onSuccess;
  @required
  final Stream<T> streams;
  final Function onError;
  final Function onWaiting;

  const Observer({Key key, this.onError, this.onSuccess, this.streams, this.onWaiting}) : super(key: key);

  // getter for return a circularProgressIndicator
  Function get _defaultOnWaiting => (context) => Center(child: CircularProgressIndicator(),);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: streams,
      builder: (BuildContext context, AsyncSnapshot snapshot){

        if(snapshot.hasError){
          return onError(context, snapshot.error);
        }

        if(snapshot.hasData){
          T data = snapshot.data;
          return onSuccess(context, data);
        }else{
          return (onWaiting != null) ? onWaiting(context) : _defaultOnWaiting(context);
        }

      },


    );
  }
}