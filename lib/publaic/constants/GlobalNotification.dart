import 'dart:convert';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:just_audio/just_audio.dart';
import 'package:score/customer/Home.dart';

import 'GlobalState.dart';

class GlobalNotification {
  final FirebaseMessaging _firebaseMessaging = new FirebaseMessaging();
  FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin;
  int _id = 0;
  static GlobalKey<NavigatorState> navigatorKey;
  Function reset=(){};
  static GlobalNotification instance = new GlobalNotification._();
  GlobalNotification._();

  setupNotification({GlobalKey<NavigatorState> navKey,Function func}) {
    navigatorKey=navKey;
    reset=func;
    _flutterLocalNotificationsPlugin=new FlutterLocalNotificationsPlugin();
    var android=new AndroidInitializationSettings("@mipmap/ic_launcher");
    var ios=new IOSInitializationSettings();
    var initSettings=new InitializationSettings(android, ios);
    _flutterLocalNotificationsPlugin.initialize(
      initSettings,
      onSelectNotification: onSelectNotification,
    );
    _firebaseMessaging.configure(
      onMessage: (Map<String,dynamic>message){
        _id+=1;
        print(message);
        _showLocalNotification(message,_id);
        return;
      },
      onResume: (Map<String,dynamic>message){
        _id+=1;
        print(message);
        _showLocalNotification(message,_id);
        return;
      },
      onLaunch: (Map<String,dynamic>message){
        _id+=1;
        print(message);
        _showLocalNotification(message,_id);
        return;
      },
    );
    _firebaseMessaging.getToken().then((token){
      print(token);
    });


  }

  static const _channel=MethodChannel("notification");

  _showNativeNotification(message)async{
    var _notify=message["notification"];
    print("notify $message");//${_notify["title"]}
    var result=await _channel.invokeMethod("connectApp",<String,dynamic>{
      "msg":"Score",
      "body":"${_notify["body"]}",
      "page": "${message["data"]["type"]}"
    });
    print(message);
  }

  final player = AudioPlayer();

  _showIosNotification(message,id)async{
    var _notify=message["notification"];
    print("notify $message");//${_notify["title"]}
    if(message["type"]==1){
      var duration = await player.setAsset('images/ring.mp3');
    }else{
      var duration = await player.setAsset('images/alert.mp3');
    }
    player.play();
    //_showLocalNotification(message,id);

  }

  _showLocalNotification(message,id)async{
    var _notify=message["notification"];
    if (Platform.isIOS)
    {
      _notify = message;
    }
    var android=new AndroidNotificationDetails(_notify["sound2"], _notify["sound2"], "${_notify["body"]}",
        sound: _notify["sound2"],
        priority: Priority.High,importance: Importance.High,
        enableVibration: true,enableLights: true);
    var ios=new IOSNotificationDetails(sound: _notify["sound2"],);
    var _platform=new NotificationDetails(android, ios);

    _flutterLocalNotificationsPlugin.show(id, "Score", "${_notify["body"]}",
        _platform,payload: json.encode(message["data"])
    );

  }




  Future onSelectNotification(payload) async {

    var obj=json.decode(payload);
    print("payload $obj");

    Future.delayed(Duration(seconds: 1),(){
      GlobalState.instance.set("orderData", payload);

//      if(obj["type"]=="1"){
//        navigatorKey.currentState.push(
//            MaterialPageRoute(builder: (context) => PayReservation())
//        );
//      }else if(obj["type"]=="6"){
//        navigatorKey.currentState.push(
//            MaterialPageRoute(builder: (context) => RateProvider())
//        );
//      }else{
//        navigatorKey.currentState.push(
//            MaterialPageRoute(builder: (context) => Notifications())
//        );
//      }



    });

  }
}
