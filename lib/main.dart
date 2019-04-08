import 'package:flutter/material.dart';
// import 'package:toast/toast.dart';
//import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'fetch_data/main_fetch_data.dart';
import 'flutter_default.dart';
import 'user_listview/user_listview.dart';
import 'myform/myform.dart';
import 'googlemap/googlemapsample.dart';
import 'animations/loader.dart';
import 'navigation/tabs.dart';
import 'navigation/slidenavigation.dart';
import 'navigation/home_page.dart';
import 'fcm/fcm.dart';
//import 'video/videoplayer';

// https://github.com/diegoveloper/flutter-samples
// https://flutter.dev/docs/cookbook/lists/basic-list
// https://pub.dartlang.org/packages/toast

void main() => runApp(MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyApp(),
    ));

class MyApp extends StatefulWidget {
  @override
  MyAppState createState() {
    return new MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  onButtonTap(Widget page) {
    Navigator.push(
        context, MaterialPageRoute(builder: (BuildContext context) => page));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter Samples"),
      ),
      body: Padding(
        padding: EdgeInsets.all(15.0),
        child: ListView(
          children: <Widget>[
            MyMenuButton(
              title: "Fetch Data JSON",
              actionTap: () {
                onButtonTap(MainFetchData());
              },
            ),
            MyMenuButton(
              title: "Flutter Default",
              actionTap: () {
                onButtonTap(FlutterDefault());
              },
            ),
            MyMenuButton(
              title: "HTTP a JSON Listview",
              actionTap: () {
                onButtonTap(UsersListView());
              },
            ),
            MyMenuButton(
              title: "My Edit Form with List",
              actionTap: () {
                onButtonTap(MyForm());
              },
            ),
            MyMenuButton(
              title: "Google Map",
              actionTap: () {
                onButtonTap(GoogleMapSample());
              },
            ),
            MyMenuButton(
              title: "Video Player",
              actionTap: () {
               // onButtonTap(VideoApp());
              },
            ),
            MyMenuButton(
              title: "Flutter Animations",
              actionTap: () {
                FlutterAnimations();
              },
            ),
            MyMenuButton(
              // https://kodestat.gitbook.io/flutter/flutter-tab-navigation
              title: "Tab Navigation",
              actionTap: () {
                TabNavigation();
              },
            ),
            MyMenuButton(
              // https://kodestat.gitbook.io/flutter/flutter-sliding-menu-using-a-drawer
              title: "Sliding menu using a Drawer Navigation",
              actionTap: () {
                SlideNavigation();
              },
            ),
            MyMenuButton(
              // https://kodestat.gitbook.io/flutter/flutter-sliding-menu-using-a-drawer/simple-drawer
              title: "Home menu a Drawer Navigation",
              actionTap: () {
                HomeNavigation();
              },
            ),
            MyMenuButton(
              // http://myhexaville.com/2018/04/09/flutter-push-notifications-with-firebase-cloud-messaging/
              // https://github.com/nitishk72/firebase_messaging_flutter
              title: "FCM",
              actionTap: () {
                FCMNotify();
              },
            )
          ],
        ),
      ),
    );
  }
}

class MyMenuButton extends StatelessWidget {
  final String title;
  final VoidCallback actionTap;

  MyMenuButton({this.title, this.actionTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: MaterialButton(
        height: 50.0,
        color: Theme.of(context).primaryColor,
        textColor: Colors.white,
        child: new Text(title),
        onPressed: actionTap,
      ),
    );
  }
}
