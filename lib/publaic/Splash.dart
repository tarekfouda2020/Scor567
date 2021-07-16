import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:score/publaic/constants/GlobalNotification.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class Splash extends StatefulWidget {
  GlobalKey<NavigatorState> navigatorKey;

  Splash(this.navigatorKey);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _splashState();
  }
}

class _splashState extends State<Splash> {
  GlobalKey<ScaffoldState> _scafold = new GlobalKey<ScaffoldState>();


  @override
  void initState() {
    super.initState();
    checkUsers();
  }

  checkUsers() async {
    GlobalNotification.instance.setupNotification(widget.navigatorKey.currentContext);
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    var _lang = _prefs.get("lang");
    _lang == null ? _prefs.setString("lang", "ar") : null;
//    var str_user= prefs.get("lang");
//    Future.delayed(Duration(seconds: 2),(){
//
//      if(str_user!=null){
//        var user=json.decode(str_user);
//        print(user["lang"]);
//        GlobalState.instance.set("lang", "${user["lang"]}");
//        if(user["lang"]=="en"){
//          lang_data.changeLocale(Locale("en"));
//        }else{
//          lang_data.changeLocale(Locale("ar"));
//        }
//      }else{
//        lang_data.changeLocale(Locale("ar"));
//      }
//      setState(() {
//
//      });
    Future.delayed(Duration(seconds: 3), () {
//        if(str_user!=null){
//          GlobalState.instance.set("user", str_user);
//          Navigator.of(context).pushReplacementNamed("/home");
//        }else{
//          GlobalState.instance.set("user", str_user);
//          Navigator.of(context).pushReplacementNamed("/home");
//        }
      context.locale=Locale("ar","EG");
      Navigator.of(context).pushReplacementNamed("/home");
    });
//
//    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Container(
      child: Scaffold(
        key: _scafold,
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: Colors.green,
              image: DecorationImage(
                  image: AssetImage("images/splash.png"), fit: BoxFit.fill)),
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 120),
                width: MediaQuery.of(context).size.width - 100,
                height: 160,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("images/scorelogo.png"),
                        fit: BoxFit.contain)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
