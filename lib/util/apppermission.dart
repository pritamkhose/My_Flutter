import 'package:flutter/material.dart';
//import 'package:simple_permissions/simple_permissions.dart';

// https://pub.dev/packages/simple_permissions#-readme-tab-
// https://pub.dev/packages/permission

void main() => runApp(appPermission());

class appPermission extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App Permission Demo',
      home: MyApp (),
    );
  }
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
//  Permission permission;

  @override
  initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  initPlatformState() async {
//    String platformVersion;
//    // Platform messages may fail, so we use a try/catch PlatformException.
//    try {
//      platformVersion = await SimplePermissions.platformVersion;
//    } on PlatformException {
//      platformVersion = 'Failed to get platform version.';
//    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
//      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text('Plugin example app'),
        ),
        body: new Center(
          child: new Column(children: <Widget>[
            new Text('Running on: $_platformVersion\n'),
//            new DropdownButton(
//                items: _getDropDownItems(),
//                value: permission,
//                onChanged: onDropDownChanged),
            new RaisedButton(
                onPressed: checkPermission,
                child: new Text("Check permission")),
            new RaisedButton(
                onPressed: requestPermission,
                child: new Text("Request permission")),
            new RaisedButton(
                onPressed: getPermissionStatus,
                child: new Text("Get permission status")),
            new RaisedButton(
                onPressed: () {}, //SimplePermissions.openSettings,
                child: new Text("Open settings")),
            new RaisedButton(
                onPressed: requestAllPermission,
                child: new Text("All Request permission"))
          ]),
        ),
      ),
    );
  }

//  onDropDownChanged(Permission permission) {
//    setState(() => this.permission = permission);
//    print(permission);
//  }
//
  requestPermission() async {
//    final res = await SimplePermissions.requestPermission(permission);
//    print("permission request result is " + res.toString());
  }
//
  requestAllPermission() async {
//    final res = await SimplePermissions.requestPermission(Permission.AccessCoarseLocation);
//    print("permission request result is " + res.toString());
//    final res1 = await SimplePermissions.requestPermission(Permission.SendSMS);
//    print("permission request result is " + res1.toString());
//    final res2 = await SimplePermissions.requestPermission(Permission.CallPhone);
//    print("permission request result is " + res2.toString());
//
  }
//
  checkPermission() async {
//    bool res = await SimplePermissions.checkPermission(permission);
//    print("permission is " + res.toString());
  }
//
  getPermissionStatus() async {
//    final res = await SimplePermissions.getPermissionStatus(permission);
//    print("permission status is " + res.toString());
 }
//
//  List<DropdownMenuItem<Permission>> _getDropDownItems() {
//    List<DropdownMenuItem<Permission>> items = new List();
//    Permission.values.forEach((permission) {
//      var item = new DropdownMenuItem(
//          child: new Text(getPermissionString(permission)), value: permission);
//      items.add(item);
//    });
//    return items;
//  }
}
