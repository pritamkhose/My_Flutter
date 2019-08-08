import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void AppSharedPreferences() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shared Preferences',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  @override
  void initState() {
    super.initState();

    _asyncGetCounter().then((result) {
      print("initState result: $result");
      setState(() {
        _counter = result;
      });
    });
  }

  _asyncGetCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int countvalue = await (prefs.getInt('counter') ?? 0);
    print('pressed _asyncGetCounter get $countvalue times.');
    _counter = countvalue;
    return countvalue;
  }

  _incrementCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _counter = (prefs.getInt('counter') ?? 0) + 1;
    print('Pressed _incrementCounter $_counter times.');
    await prefs.setInt('counter', _counter);

    setState(() {
      _counter = _counter;
    });
//  int counter = ( int.parse(prefs.getString('counter'));  ?? 0) + 1;
//  print('Pressed $counter times.');
//  await prefs.setString('counter', counter.toString());
  }


  _clearPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print('Pressed _clear.');
    await prefs.clear();

    setState(() {
      _counter = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
//            Text(
//              'You have pushed the button this many times:',
//            ),
//            Text(
//              '$_counter',
//              style: Theme.of(context).textTheme.display1,
//            ),
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
            new RaisedButton(
              onPressed: _asyncGetCounter,
              child: Text('Get Counter'),
            ),
          ],
        ),
      ),
//      floatingActionButton: FloatingActionButton(
//        onPressed: _incrementCounter,
//        tooltip: 'Increment',
//        child: Icon(Icons.add),
//      ),
    );
  }
}
