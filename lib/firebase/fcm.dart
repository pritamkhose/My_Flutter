import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'dart:async';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'notifymessage.dart';

void FCMNotify() => runApp(new MyApp());
// void main() => runApp(FCMNotify());

/*class MyApp extends StatelessWidget {
  final String appTitle = 'Firebase messaging';
  @override
  Widget build(BuildContext context) => MaterialApp(
    title: appTitle,
    home: MainPage(appTitle: appTitle),
  );
}

class MainPage extends StatelessWidget {
  final String appTitle;

  const MainPage({this.appTitle});

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: Text(appTitle),
    ),
    body: MessagingWidget(),
  );
}*/

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Firebase messaging',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(title: 'FCM messaging'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  final List<NotifyMessage> messages = [];

  FirebaseMessaging _firebaseMessaging = new FirebaseMessaging();
  String atoken = '';
  String atitle = 'No title';
  String amessage = 'No message';
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) {
        print('on message $message');

        final notification = message['notification'];
        setState(() {
          messages.add(NotifyMessage(
            title: '${notification['title']}',
            body: '${notification['body']}',
          ));
        });

        showfcmNotification(messages);
      },
      onResume: (Map<String, dynamic> message) {
        print('on resume $message');
      },
      onLaunch: (Map<String, dynamic> message) {
        print('on launch $message');

        final notification = message['notification'];
        setState(() {
          messages.add(NotifyMessage(
            title: '${notification['title']}',
            body: '${notification['body']}',
          ));
        });
      },
    );
    _firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(sound: true, badge: true, alert: true));
    _firebaseMessaging.getToken().then((token) {
      print(token);
      setState(() {
        atoken = token;
      });
    });

    // initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
    flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
    var android = new AndroidInitializationSettings('@mipmap/ic_launcher');
    var iOS = new IOSInitializationSettings();
    var initSetttings = new InitializationSettings(android, iOS);
    flutterLocalNotificationsPlugin.initialize(initSetttings,
        onSelectNotification: onSelectNotification);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: Container(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                validator: (value) {
                  if (value.isEmpty || value.length < 1) {
                    return 'Enter title';
                  } else {
                    atitle = value;
                  }
                },
                onSaved: (String value) {
                  atitle = value;
                },
              ),
              TextFormField(
                validator: (value) {
                  if (value.isEmpty || value.length < 1) {
                    return 'Enter message';
                  } else {
                    amessage = value;
                  }
                  return null;
                },
                onSaved: (String value) {
                  print(value);
                  amessage = value;
                },
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  RaisedButton(
                      child: new Text("Send FCM Notification"),
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          _sendNotify(atitle, amessage);
                        } else {
                          Fluttertoast.showToast(msg: 'Enter title & message');
                        }
                      }),
                  RaisedButton(
                    child: new Text("Local Notification"),
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        showNotification(atitle, amessage);
                      } else {
                        Fluttertoast.showToast(msg: 'Enter title & message');
                      }
                    },
                  ),
                  Text('Device Token = ' + atoken),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  var isLoading = false;

  _sendNotify(atitle, amessage) async {
    try {
      setState(() {
        isLoading = true;
      });

      Map<String, String> header = {
        'Content-Type': 'application/json',
        'Authorization': 'key=AIzaSyCvymv0xqjJnnYQe0AMRVQdMjmryliiS4E'
      };

      Map<String, dynamic> formData = {
        "registration_ids": [atoken],
        "priority": "high",
        "notification": {
          "title": atitle,
          "body": amessage
        },
        "data": {
          "Key-1": "JSA Data 1",
          "Key-2": "JSA Data 2",
          "Key-3": "JSA Data 3"
        }
      };

      print('--> ' + formData.toString() + '\n' + header.toString());

      final response = await http.post(
        "https://fcm.googleapis.com/fcm/send",
        headers: header,
        body: json.encode(formData),
      );
      if (response.statusCode == 200) {
        setState(() {
          isLoading = false;
          _ackAlert(
              context,
              'Send Sucessfully! ' + response.statusCode.toString(),
              response.body.toString());
        });
      } else {
        setState(
          () {
            isLoading = false;
          },
        );
        _ackAlert(
            context,
            'Error - Http error ' + response.statusCode.toString(),
            response.body.toString());
      }
    } on SocketException catch (_) {
      _ackAlert(context, 'Offline', 'No Ineternet available');
    } on Exception catch (e) {
      _ackAlert(context, 'Exception', e.toString());
    }
  }

  // http://androidkt.com/flutter-alertdialog-example/
  Future<void> _ackAlert(BuildContext context, String title, String msg) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(msg),
          actions: <Widget>[
            FlatButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future onSelectNotification(String payload) {
    debugPrint("payload : $payload");
    showDialog(
      context: context,
      builder: (_) => new AlertDialog(
        title: new Text('Notification'),
        content: new Text('$payload'),
      ),
    );
  }

  showNotification(_title, _message) async {
    var android = new AndroidNotificationDetails(
        'channel id', 'channel NAME', 'CHANNEL DESCRIPTION',
        priority: Priority.High, importance: Importance.Max);
    var iOS = new IOSNotificationDetails();
    var platform = new NotificationDetails(android, iOS);
    await flutterLocalNotificationsPlugin.show(0, _title, _message, platform,
        payload: 'Nitish Kumar Singh is part time Youtuber');
  }

  showfcmNotification(List<NotifyMessage> message) async {
    var android = new AndroidNotificationDetails(
        'channel id', 'channel NAME', 'CHANNEL DESCRIPTION',
        priority: Priority.High, importance: Importance.Max);
    var iOS = new IOSNotificationDetails();
    var platform = new NotificationDetails(android, iOS);
    await flutterLocalNotificationsPlugin.show(
        0, message[0].title, message[0].body, platform,
        payload: 'FCM Notification');
  }
}
