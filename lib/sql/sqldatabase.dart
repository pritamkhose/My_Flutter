import 'package:flutter/material.dart';
import 'screens/note_list.dart';

class MySqlDatabase extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new MaterialApp(
      title: 'SQLite NoteKeeper DataBase Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: NoteList(),
    );
  }
}
