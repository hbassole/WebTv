

import 'package:webtv_app/manager/CategorieManager.dart';
import 'package:webtv_app/manager/LikeManager.dart';
import 'package:webtv_app/manager/Manager.dart';
import 'package:webtv_app/manager/UserformManager.dart';
import 'package:webtv_app/manager/UserManager.dart';
import 'package:webtv_app/manager/VideoManager.dart';
import 'package:webtv_app/manager/DirectManager.dart';

class  Overseer {

  Map<dynamic, Manager> repository = {};

  Map<dynamic, Function> _factories = {
    UserFormManager : () => UserFormManager(),
    UserManager : () => UserManager(),
    CategoriesManager : () => CategoriesManager(),
    VideoManager : () => VideoManager(),
    DirectManager : () => DirectManager(),
    LikeManager : () => LikeManager(),
  };

  // Construct

 static final Overseer _singleton = Overseer._internal();
 Overseer._internal();

 factory Overseer() => _singleton;

 _summon(name)=> repository[name] = _factories[name]();

 /*
  Overseer(){
    register(UserFormManager, UserFormManager());
    register(UserManager, UserManager());
    register(CategoriesManager, CategoriesManager());
    register(VideoManager, VideoManager());
    register(DirectManager, DirectManager());
  }

  */

  /// FIRST METHOD
  /// Register
  /// ex with contactList
  /// repository {
  /// ContactManager : { dataOfContactManager },
  /// .....
  ///
  /// }
  ///

  register(name, object){
    repository[name] = object;
  }

  /// FETCH

  fetch(name) => repository.containsKey(name) ? repository[name] : _summon(name);

  release(name){
    Manager manager = repository[name];
    manager.dispose();

    repository.remove(name);
  }

}