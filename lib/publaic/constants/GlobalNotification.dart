import 'dart:async';
import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';


class GlobalNotification {
  static StreamController<Map<String, dynamic>> _onMessageStreamController =
  StreamController.broadcast();

  FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin;
  static BuildContext context;
  static GlobalNotification instance = new GlobalNotification._();
  static FirebaseMessaging messaging = FirebaseMessaging.instance;
  GlobalNotification._();

  GlobalNotification();

  setupNotification(BuildContext cxt)async{
    context = cxt;
    _flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
    var android = new AndroidInitializationSettings("@mipmap/launcher_icon");
    var ios = new IOSInitializationSettings();
    var initSettings = new InitializationSettings(android: android, iOS: ios);
    _flutterLocalNotificationsPlugin.initialize(
      initSettings,
      onSelectNotification: flutterNotificationClick,
    );
    NotificationSettings settings = await messaging.requestPermission(provisional: true);
    print('User granted permission: ${settings.authorizationStatus}');
    if(settings.authorizationStatus==AuthorizationStatus.authorized){
      messaging.getToken().then((token) {
        print(token);
      });
      messaging.setForegroundNotificationPresentationOptions(alert: false,badge: false,sound: false);
      // messaging.getInitialMessage().then((message) => _showLocalNotification(message));
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        print("_____________________Message data:${message.data}");
        print("_____________________notification:${message.notification?.title}");
        _showLocalNotification(message);
        _onMessageStreamController.add(message.data);
      });
      FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
        print('A new onMessageOpenedApp event was published!');
        flutterNotificationClick(json.encode(message.data));
      });
      FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    }

  }

  static Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    print("Handling a background message: ${message.messageId}");
    flutterNotificationClick(json.encode(message.data));
  }

  StreamController<Map<String, dynamic>> get notificationSubject {
    return _onMessageStreamController;
  }

  _showLocalNotification(RemoteMessage message) async {
    if (message == null) return;
    var android = AndroidNotificationDetails(
      "${DateTime.now()}",
      "${message.notification?.title}",
      "${message.notification?.body}",
      sound: RawResourceAndroidNotificationSound(message.data["sound2"]),
      priority: Priority.high,
      importance: Importance.max,
      playSound: true,
      shortcutId: DateTime.now().toIso8601String(),
    );
    var ios = IOSNotificationDetails(sound: message.data["sound2"]);
    var _platform = NotificationDetails(android: android, iOS: ios);
    _flutterLocalNotificationsPlugin.show(
        DateTime.now().microsecond, "${message.notification?.title}", "${message.notification?.body}", _platform,
        payload: json.encode(message.data));
  }

  static Future flutterNotificationClick(String payload) async {
    print("tttttttttt $payload");
    var _data = json.decode("$payload");

    int _type = int.parse(_data["type"] ?? "4");
  }

}
