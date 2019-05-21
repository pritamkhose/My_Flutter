import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void AppSharedPreferences() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shared Preferences',
      home: Scaffold(
        body: Center(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              new Center(
                child: Text(
                  'Button tapped $_counter time${_counter == 1 ? '' : 's'}.',
                ),
              ),
              // https://medium.com/@yuvrajpandey24/working-with-raised-button-in-flutter-6f5c0f71aab3
              new RaisedButton(
                onPressed: _incrementCounter,
                child: Text('Increment Counter'),
              ),
              new RaisedButton(
                onPressed: _clearPref,
                child: Text('Clear Counter'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

int _counter = 0;
_incrementCounter() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  _counter = (prefs.getInt('counter') ?? 0) + 1;
  print('Pressed $_counter times.');
  await prefs.setInt('counter', _counter);

//  int counter = ( int.parse(prefs.getString('counter'));  ?? 0) + 1;
//  print('Pressed $counter times.');
//  await prefs.setString('counter', counter.toString());
}

_clearPref() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  print('Pressed _clear Counteres.');
  await prefs.clear();
}
