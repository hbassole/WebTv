import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:webtv_app/Models/UserLogin.dart';
import 'package:webtv_app/manager/Manager.dart';
import 'package:webtv_app/manager/validation.dart';
import 'package:rxdart/streams.dart';
import 'package:webtv_app/services/UserService.dart';
import 'package:shared_preferences/shared_preferences.dart';


class UserFormManager with Validation implements Manager {

  final PublishSubject _isSessionValid = PublishSubject<bool>();
  Stream<bool> get isSessionValid => _isSessionValid.stream;
  int id ;
  String name = "" ;
  UserInfo user ;
  String email = "" ;
  String contact = "" ;
  String avatar = "" ;

  BehaviorSubject<String> _username = BehaviorSubject<String>();

  // expose extremiter
  Sink<String> get inUsername => _username.sink;

  // access au flux
  Stream<String> get username$ => _username.stream.transform(validateUsername);

  /// ************************
  /// *****  register Password


  BehaviorSubject<String> _password =  BehaviorSubject<String>();
  // expose extremiter
  Sink<String> get inPassword => _password.sink;
  // access au flux
  Stream<String> get password$ => _password.stream.transform(validatePassword);



  /// ************************
  /// *****  Make Submit

  Stream<bool> get isFormValid$ {
    return CombineLatestStream.combine2(username$,password$, (email, password) {
      return true;
    });
  }

  Stream<bool> get isFormValide$ =>
      Rx.combineLatest([username$,password$], (value) => true);

   submit()async{

    String username = _username.value ;
    String password = _password.value ;

    try{
      var successInformation = await UserService.login(username: username , password : password);

      if(successInformation.success == true){
        print("vous etes logger");
        //print(successInformation.user.avatar);

        name = username;
        user = successInformation.user;
        id = successInformation.user.id;
        avatar = successInformation.user.avatar;
        contact = successInformation.user.contact;
        email = successInformation.user.email;

        openSession(id,username, password, avatar, contact, email);
        //print(successInformation.user.);
        return successInformation;
      }else{
        print("vous identifiant ne sont pas correct");
        _isSessionValid.sink.add(false);
      }

      if(successInformation == null){
        print('aucune donner');
      }
    }catch(e){
      return null;
    }
  }

  void openSession(int id_user,  String username, String password, String avatar, String contact, String email)async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("username", username);
    await prefs.setInt("id", id_user);
    await prefs.setString("password", password);
    await prefs.setString("email", email);
    await prefs.setString("contact", contact);
    await prefs.setString("avatar", avatar);

    _isSessionValid.sink.add(true);
  }

  void closeSession() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("id");
    prefs.remove("username");
    prefs.remove("password");
    _isSessionValid.sink.add(false);
  }

  void restoreSession() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String name =  prefs.getString("username");
    String pwd =  prefs.getString("password");

  
    print("+++++++++++++++++++++++++++++++++");
    print(name);
    print(pwd);

    if ((name != null && name.length > 0) && (pwd != null && pwd.length > 0)) {
      print("ok");
      _isSessionValid.sink.add(true);
    } else {
      _isSessionValid.sink.add(false);
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
  }

  /*

  void dispose(){
    _username.close();
    _password.close();
    _isSessionValid.close();
  }
   */


}

final authBloc = UserFormManager();