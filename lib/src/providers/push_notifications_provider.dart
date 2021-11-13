import 'dart:async';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotificationProvider {

  final _mensajeStreamController = StreamController<String>.broadcast();
  Stream<String> get mensajes => _mensajeStreamController.stream;

  initNotifications() {
    FirebaseMessaging.instance.requestPermission();

    FirebaseMessaging.instance.getToken().then( (token) {

      print(' FCM ');
      print( token );

      //coMkFB3rSFqe40OvCVSxNx:APA91bFvLSPW7oXR3ctU8gxGDMgEjHb7yqvrvh5nSDHtWegeIa39My9Da8Vzz-68eeJMBKrF-V9-6RW2ReW0hXQGBDd_momlLm-iEe7eugieExlnQiPnD-tHlIlOANAqxmbh-TejPin2
    
    } );

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('========= On message ==== ');
      print(message.notification?.title);
      print(message.notification?.body);
      print(message.data);

      String argumento = 'no-data';
      if( Platform.isAndroid ) {
        argumento = message.data['comida'] ?? 'no-data';
      }

      _mensajeStreamController.sink.add(argumento);

      // final noti = message.data['comida'];
      // print('dwsds  ' + noti);
      // RemoteNotification? notification = message.notification;
      // AndroidNotification? android = message.notification?.android;
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print(' ===== onLaunch o resume ======');
      print(message.notification?.title);
      print(message.notification?.body);
      print(message.data);

      String argumento = 'no-data';
      if( Platform.isAndroid ) {
        argumento = message.data['comida'] ?? 'no-data';
      }

      _mensajeStreamController.sink.add(argumento);

      // final noti = message.data['comida'];
      // print('dwsds  ' + noti);
      // Navigator.pushNamed(context, '/message',
      //     arguments: MessageArguments(message, true));
    });

  }

  dispose() {
    _mensajeStreamController.close();
  }

}