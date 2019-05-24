import 'package:flutter/material.dart';
import 'dart:async';
// import 'package:fast_qr_reader_view/fast_qr_reader_view.dart';

class FastQRScreen extends StatefulWidget {
  @override
  _FASTQRScanState createState() => new _FASTQRScanState();
}

class _FASTQRScanState extends State<FastQRScreen> {

  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
          title: new Text('QR Code Scanner'),
        ),
        body: new Center(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: RaisedButton(
                    color: Colors.blue,
                    textColor: Colors.white,
                    splashColor: Colors.blueGrey,
                    onPressed: main,
                    child: const Text('START CAMERA SCAN')
                ),
              )
              ,
            ],
          ),
        ));
  }
}

// copy code from https://pub.dev/packages/fast_qr_reader_view#-example-tab-
Future<Null> main() async {
  // Fetch the available cameras before initializing the app.
}