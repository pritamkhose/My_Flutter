import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';

import 'model/app_state_model.dart';
import 'cupertino-store-home.dart';


void CupertinoStoreApp(){
  // This app is designed only to work vertically, so we limit
  // orientations to portrait up and down.
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  return runApp(
    ChangeNotifierProvider<AppStateModel>(
      builder: (context) => AppStateModel()..loadProducts(),
      child: CupertinoStoreHome(),
    ),
  );
//  runApp(
//      new MaterialApp(
//          home: new CupertinoStoreHome()
//      )
//  );
}