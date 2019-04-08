import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void FlutterNative() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter-Native Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(title: 'Channel demo app'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  static const platform = const MethodChannel(
      'com.example.my_flutter');
  final String title;

  MyHomePage({Key key, this.title}) : super(key: key) {
    platform.setMethodCallHandler(_handleMethod);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(title),
      ),
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new RaisedButton(
              child: new Text('Show native view'),
              onPressed: _showNativeView,
            ),
            new RaisedButton(
              child: new Text('Show changeLife'),
              onPressed: _showChangeLife,
            ),
          ],
        ),
      ),
    );
  }

  Future<Null> _showNativeView() async {
    await platform.invokeMethod('showNativeView');
  }

  Future<dynamic> _handleMethod(MethodCall call) async {
    print('-->> '+ call.method);
    switch(call.method) {
      case "message":
        debugPrint(call.arguments);
        return new Future.value("");
    }
  }

  Future<Null> _showChangeLife() async {
    await platform.invokeMethod('changeLife');
  }
}