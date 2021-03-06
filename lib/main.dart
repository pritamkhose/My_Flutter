import 'package:flutter/material.dart';

//import 'package:fluttertoast/fluttertoast.dart';
import 'fetch_data/main_fetch_data.dart';
import 'user_listview/user_listview.dart';
import 'myform/myform.dart';
import 'googlemap/googlemapsample.dart';
import 'googlemap/googlemapmarker.dart';
import 'googlemap/geolocatorloc.dart';
import 'firebase/fcm.dart';
import 'animations/loader.dart';
import 'navigation/tabs.dart';
import 'navigation/slidenavigation.dart';
import 'navigation/home_page.dart';
import 'util/url_launcher.dart';
import 'util/sms.dart';
import 'util/mywebview.dart';
import 'util/applicationpermission.dart';
import 'flutternative/flutternative.dart';
import 'samplescreen/netfilx.dart';
import 'samplescreen/instagram.dart';
import 'samplescreen/secretsanta.dart';
import 'samplescreen/amazon.dart';
import 'samplescreen/adidas.dart';
import 'fileexploer/reading-writing-file.dart';
import 'fileexploer/filepicker.dart';
import 'shared_preferences/app_shared_preferences.dart';
import 'qr/qrscanner.dart';
import 'video/chewievideoplayer.dart';
import 'video/soundrecordplayer.dart';
import 'sql/sqldatabase.dart';
import 'hivedb/myhivedb.dart';
import 'sentry/sentrycrashy.dart';
import 'firebase/firebasehome.dart';
import 'firebase/ml_vision_firebase.dart';
import 'codelab/flutter_default.dart';
import 'codelab/cupertino-store-app.dart';
import 'codelab/flutter_listview.dart';
import 'codelab/main_friendlychat.dart';
import 'maxmillian/maxmillian.dart';

/* Link
 https://github.com/diegoveloper/flutter-samples
 https://flutter.dev/docs/cookbook/lists/basic-list
 https://pub.dartlang.org/packages/toast
 https://pub.dartlang.org/flutter/packages
 https://flutter.dev/docs/development/packages-and-plugins/androidx-compatibility
 https://github.com/Solido/awesome-flutter
 https://github.com/flutter/plugins
*/

void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
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

  // https://stackoverflow.com/questions/40579879/display-snackbar-in-flutter
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  DateTime currentBackPressTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Flutter Samples"),
      ),
      body: WillPopScope(child: getBody(), onWillPop: onWillPop),
    );
  }

  getBody() {
    return Padding(
      padding: EdgeInsets.all(15.0),
      child: ListView(
        children: <Widget>[
          MyMenuButton(
            title: "Flutter Default",
            actionTap: () {
              onButtonTap(FlutterDefault());
            },
          ),
          MyMenuButton(
            title: "Fetch Data JSON",
            actionTap: () {
              onButtonTap(MainFetchData());
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
//          MyMenuButton(
//            // https://pub.dev/packages/dio
//            title: "dio Http client for Dart",
//            actionTap: () {
//              onButtonTap(dioHttpClient());
//            },
//          ),
          MyMenuButton(
            // https://pub.dev/packages/google_maps_flutter
            title: "Google Map",
            actionTap: () {
              onButtonTap(GoogleMapSample());
            },
          ),
          MyMenuButton(
            // https://medium.com/flutter-io/google-maps-and-flutter-cfb330f9a245
            // https://github.com/flutter/plugins/tree/master/packages/google_maps_flutter/example
            // https://pub.dev/packages/google_maps_flutter
            // https://codelabs.developers.google.com/codelabs/google-maps-in-flutter/#3
            // https://medium.com/flutterpub/flutter-and-google-maps-2b4e332e24ec
            // https://medium.com/flutter-community/exploring-google-maps-in-flutter-8a86d3783d24
            title: "Google Map Marker",
            actionTap: () {
              onButtonTap(GoogleMapMarker());
            },
          ),
          MyMenuButton(
            // https://pub.dev/packages/geolocator
            // https://github.com/BaseflowIT/flutter-geolocator/blob/develop/example/lib/main.dart
            title: "Geolocator",
            actionTap: () {
              onButtonTap(GeolocatorExampleApp());
            },
          ),
          MyMenuButton(
            // https://flutter.dev/docs/development/data-and-backend/firebase
            // https://firebaseopensource.com/projects/flutter/plugins/
            // https://codelabs.developers.google.com/codelabs/flutter-firebase/index.html#10
            title: "Firebase",
            actionTap: () {
              onButtonTap(FirebaseHome());
            },
          ),
          MyMenuButton(
            // https://pub.dev/packages/firebase_ml_vision
            // https://github.com/flutter/plugins/blob/master/packages/firebase_ml_vision/example/lib/main.dart
            title: "Firebase ML vision",
            actionTap: () {
              onButtonTap(FirebaseMLKitHome());
            },
          ),
          MyMenuButton(
            // http://myhexaville.com/2018/04/09/flutter-push-notifications-with-firebase-cloud-messaging/
            // https://github.com/nitishk72/firebase_messaging_flutter
            // https://pub.dartlang.org/packages/firebase_messaging#-readme-tab-
            // https://console.firebase.google.com/u/1/project/fiberbase-4b621/settings/general/android:com.example.my_flutter
            // https://github.com/IhorKlimov/Flutter-Notifications
            // https://github.com/JohannesMilke/firebase_messaging --run standalone
            title: "FCM",
            actionTap: () {
              FCMNotify();
            },
          ),
//          MyMenuButton(
//            // https://pub.dev/packages/local_notifications extra
//            // https://pub.dev/packages/flutter_local_notifications#-example-tab-
//            // https://github.com/MaikuB/flutter_local_notifications/blob/master/example/lib/main.dart extra
//            // https://github.com/nitishk72/flutter_app_local_notification/blob/master/lib/main.dart
//            title: "Local Notification",
//            actionTap: () {
//              LocalMyNotify();
//            },
//          ),
//          MyMenuButton(
//            // https://pub.dev/packages/simple_permissions#-readme-tab-
//            // https://github.com/tamcy/simple_permissions
//            // https://pub.dev/packages/permission
//            // https://github.com/once10301/permission/blob/master/example/lib/main.dart
//            title: "App permission",
//            actionTap: () {
//              onButtonTap(AppPermission());
//            },
//          ),
          MyMenuButton(
            // https://pub.dev/packages/permission_handler#-installing-tab-
            // https://github.com/BaseflowIT/flutter-permission-handler/blob/develop/example/lib/main.dart
            title: "Application permission",
            actionTap: () {
              onButtonTap(ApplicationPermission());
            },
          ),
          MyMenuButton(
            // https://github.com/flutter/plugins/blob/master/packages/video_player/example/lib/main.dart
            // https://pub.dartlang.org/packages/video_player#-installing-tab-
            // https://github.com/tensor-programming/flutter_videoplayer_example/blob/master/lib/main.dart
            // https://github.com/brianegan/chewie
            // https://pub.dev/packages/chewie#-installing-tab-
            title: "Video Player chewie",
            actionTap: () {
              MyVideoPlayerScreen();
            },
          ),
          MyMenuButton(
            // https://pub.dev/packages/flutter_sound
            // https://github.com/dooboolab/flutter_sound/blob/master/example/lib/main.dart
            title: "Sound Record Player",
            actionTap: () {
              SoundRecordPlayer();
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
            // https://pub.dev/packages/sqflite
            // https://flutter.dev/docs/cookbook/persistence/sqlite
            // https://medium.com/@studymongolian/simple-sqflite-database-example-in-flutter-e56a5aaa3f91
            // https://github.com/smartherd/Flutter-Demos/blob/master/lib
            title: "Sql Database",
            actionTap: () {
              onButtonTap(MySqlDatabase());
            },
          ),
           MyMenuButton(
            // https://github.com/ResoCoder/hive-db-tutorial
            // https://resocoder.com/2019/09/30/hive-flutter-tutorial-lightweight-fast-database/
            // https://pub.dev/packages/hive
            title: "Hive DB",
            actionTap: () {
              onButtonTap(HiveDB());
            },
          ),
          MyMenuButton(
            // https://pub.dev/packages/shared_preferences
            // https://medium.com/flutter-community/shared-preferences-how-to-save-flutter-application-settings-and-user-preferences-for-later-554d08671ae9
            // https://medium.com/@vignesh_prakash/flutter-sharedpreferences-8622bb32abf9
            title: "Shared Preferences",
            actionTap: () {
              AppSharedPreferences();
            },
          ),
          MyMenuButton(
            // https://pub.dev/packages/path_provider
            // https://flutter.dev/docs/cookbook/persistence/reading-writing-files
            title: "File Editor internal storage",
            actionTap: () {
              FlutterFileExploer();
            },
          ),
          MyMenuButton(
            // https://github.com/miguelpruivo/plugins_flutter_file_picker/blob/master/example/lib/main.dart
            title: "File Picker",
            actionTap: () {
              FlutterFilePicker();
            },
          ),
          MyMenuButton(
            // https://pub.dev/packages/qr_flutter
            //https://medium.com/flutter-community/building-flutter-qr-code-generator-scanner-and-sharing-app-703e73b228d3
            //https://github.com/alfianlosari/flutter_qr_code_scanner_generator_sharing
            //https://pub.dev/packages/barcode_scan#-installing-tab-
            //https://pub.dev/packages/fast_qr_reader_view
            title: "QR Code",
            actionTap: () {
              QRCodeScanner();
            },
            //Extra
            //https://pub.dev/packages/qr_code_scanner#-readme-tab-
            //https://pub.dev/packages?q=qr
            //https://github.com/swissonid/BarcodeScannerPlugin
          ),
          MyMenuButton(
            // https://pub.dev/packages/webview_flutter#-example-tab-
            // https://github.com/flutter/plugins/blob/master/packages/webview_flutter/example/lib/main.dart
            title: "WebView",
            actionTap: () {
              MyWebView();
            },
          ),
          MyMenuButton(
            title: "Flutter Animations",
            actionTap: () {
              FlutterAnimations();
            },
          ),
	        MyMenuButton(
            title: "Maxmillion APP",
            actionTap: () {
              onButtonTap(MaxmillionAPP());
            },
          ),
          MyMenuButton(
            // https://pub.dev/packages/shrine_images
            // https://codelabs.developers.google.com/?cat=Flutter
            // https://codelabs.developers.google.com/codelabs/flutter-cupertino/index.html?index=..%2F..index#2
            // https://github.com/googlecodelabs/flutter-cupertino-store/tree/master/step-06/lib
            title: "Cupertino Store App",
            actionTap: () {
              CupertinoStoreApp();
            },
          ),
        MyMenuButton(
          // https://flutter.dev/docs/get-started/codelab
          // https://codelabs.developers.google.com/?cat=Flutter
          // https://codelabs.developers.google.com/codelabs/first-flutter-app-pt1/#0
          // https://codelabs.developers.google.com/codelabs/first-flutter-app-pt2/#0
          title: "Flutter List Words",
          actionTap: () {
            MyAppList();
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
            // https://pub.dev/packages/sentry#-installing-tab-
            // https://sentry.io/settings/account/api/applications/
            // https://sentry.io/organizations/pritam-khose/projects/pritam-khose/getting-started/
            // https://github.com/flutter/crashy/blob/master/lib/main.dart
            title: "Sentry Crashy logger",
            actionTap: () {
              MySentryCrashy();
            },
          ),
          MyMenuButton(
            // https://github.com/KalleHallden/Netflix_Clone
            title: "Netfilx clone",
            actionTap: () {
              NetfilxClone();
            },
          ),
          MyMenuButton(
            // https://github.com/KalleHallden/Instagram
            title: "Instagram clone",
            actionTap: () {
              InstagramClone();
            },
          ),
          MyMenuButton(
            // https://github.com/KalleHallden/SecretSantaFlutterApp/blob/master/secretsanta/lib/main.dart
            title: "Secret Santa clone",
            actionTap: () {
              SecretSantaClone();
            },
          ),
          MyMenuButton(
            title: "Amazon clone",
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
            // https://flutter.dev/docs/get-started/codelab
            // https://codelabs.developers.google.com/codelabs/flutter/index.html?index=..%2F..index#3
            title: "Friendly chat App",
            actionTap: () {
              FriendlychatApp();
            },
          ),
//          MyMenuButton(
//            // https://github.com/frideosapps/data_examples
//            // https://medium.com/flutter-community/simple-ways-to-pass-to-and-share-data-with-widgets-pages-f8988534bd5b
//            title: "Intent data send example",
//            actionTap: () {
//              // DataExamples();
//            },
//          ),
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
      // Fluttertoast.showToast(msg: 'Click once more for Exiting MyFlutter App');
      // Find the Scaffold in the widget tree and use it to show a SnackBar.
      _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text('Click once more for Exit App!')));
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
