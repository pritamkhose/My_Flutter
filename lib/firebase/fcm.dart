import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'messaging_widget.dart';

void FCMNotify() => runApp(new MyApp());

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
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(title: 'Flutter Demo Home Page'),
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
  FirebaseMessaging _firebaseMessaging = new FirebaseMessaging();
  String atoken = '';

  @override
  void initState() {
    super.initState();
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) {
        print('on message $message');
      },
      onResume: (Map<String, dynamic> message) {
        print('on resume $message');
      },
      onLaunch: (Map<String, dynamic> message) {
        print('on launch $message');
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
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              child: new Text("Send Notification"),
              onPressed: _sendNotify,
            ),
            Text('Device Token = '+ atoken),
          ],
        ),
      ),
    );
  }

  var isLoading = false;

  _sendNotify() async {
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
          "title": "Pritam Multiple Notification",
          "body": "Pritam is Very Very Happy with FCM!"
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
              'Save Sucessfully! ' + response.statusCode.toString(),
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
}
