import 'package:flutter/material.dart';
import 'userslist.dart';

void main() => runApp(UsersListView());

class UsersListView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Users',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primarySwatch: Colors.lightBlue
        ),
        home: UsersList()

    );
  }
}