import 'package:flutter/material.dart';
// import 'package:toast/toast.dart';
//import 'package:fluttertoast/fluttertoast.dart';

import 'fetch_data/main_fetch_data.dart';

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
                title: "Persistent Tab Bar",
                actionTap: () {
                  onButtonTap(MyApp());
                }),
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