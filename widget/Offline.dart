import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';

class OfflineWrapper extends StatelessWidget {

  final Widget online;
  final Widget offline;
  OfflineWrapper({this.online, this.offline});

  @override
  Widget build(BuildContext context) {
    return OfflineBuilder(
      connectivityBuilder: (BuildContext context,ConnectivityResult connectivity,Widget child,) {

        final bool connected = connectivity != ConnectivityResult.none;
        return connected ? online : offline;
      },
      child: Container(
        child: Center(child: Text("pas de connection"),),
      ),
    );
  }
}

