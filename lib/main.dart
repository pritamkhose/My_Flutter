import 'package:flutter/material.dart';
// import 'package:toast/toast.dart';
import 'package:fluttertoast/fluttertoast.dart';

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
import 'util/url_launcher.dart';
import 'util/sms.dart';
import 'flutternative/flutternative.dart';
import 'samplescreen/netfilx.dart';
import 'samplescreen/amazon.dart';
import 'samplescreen/adidas.dart';
//import 'video/videoplayer';

// https://github.com/diegoveloper/flutter-samples
// https://flutter.dev/docs/cookbook/lists/basic-list
// https://pub.dartlang.org/packages/toast
// https://pub.dartlang.org/flutter/packages

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

  DateTime currentBackPressTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter Samples"),
      ),
     // body: getBody(),
      body: WillPopScope(child: getBody(), onWillPop: onWillPop),
    );
  }

  getBody() {
    return Padding(
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
            // https://pub.dartlang.org/packages/firebase_messaging#-readme-tab-
            // https://console.firebase.google.com/u/1/project/fiberbase-4b621/settings/general/android:com.example.my_flutter
            title: "FCM",
            actionTap: () {
              FCMNotify();
            },
          ),
          MyMenuButton(
            // https://pub.dartlang.org/packages/url_launcher#-readme-tab-
            // https://pusher.com/tutorials/flutter-listviews
            // https://flutter.dev/docs/cookbook/lists/basic-list
            title: "Url Launcher",
            actionTap: () {
              URLLauncher();
            },
          ),
          MyMenuButton(
            // https://github.com/babariviere/flutter_sms
            // https://pub.dartlang.org/packages/flutter_sms
            // https://github.com/AppleEducate/plugins/tree/master/packages/flutter_sms/example
            // https://www.iflutter.in/flutter-sms/
            // https://xencov.com/blog/building-a-basic-sms-app-using-flutter-part-1
            title: "SMS",
            actionTap: () {
              SMSContact();
            },
          ),
          MyMenuButton(
            // https://proandroiddev.com/communication-between-flutter-and-native-modules-9b52c6a72dd2
            // https://github.com/RafaO/FlutterNativeCommunication/blob/master/lib/main.dart
            title: "Flutter Native Communication",
            actionTap: () {
              FlutterNative();
            },
          ),
          MyMenuButton(
            // https://codeload.github.com/KalleHallden/Netflix_Clone/zip/master
            title: "Netfilx clone",
            actionTap: () {
              NetfilxClone();
            },
          ),
          MyMenuButton(
            title: "My try Amazon clone",
            actionTap: () {
              AmazonClone();
            },
          ),
          MyMenuButton(
            // https://github.com/devefy/Flutter-Adidas-Shoes-Ecommerce-App-UI
            title: "Adidas clone",
            actionTap: () {
              AdidasClone();
            },
          ),
          MyMenuButton(
            // https://github.com/frideosapps/data_examples
            title: "Intent data send example",
            actionTap: () {
              // DataExamples();
            },
          )
        ],
      ),
    );
  }

  // https://pub.dartlang.org/packages/fluttertoast
  // https://stackoverflow.com/questions/53496161/how-to-write-a-double-back-button-pressed-to-exit-app-using-flutter
  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (now.difference(currentBackPressTime) > Duration(seconds: 1)) {
      currentBackPressTime = now;
      Fluttertoast.showToast(msg: 'Click once more for Exiting MyFlutter App');
      return Future.value(false);
    }
    return Future.value(true);
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
