import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UsersList extends StatefulWidget {
  static String tag = 'users-page';

  @override
  State<StatefulWidget> createState() {
    return new _UsersListState();
  }
}

class _UsersListState extends State<UsersList> {
  @override
  Future<List<User>> _getUsers() async {
    List<User> users = [];
    var response = await http.get('https://api.randomuser.me/?results=20');

    var jsonData = json.decode(response.body);

    var usersData = jsonData["results"];

    for (var user in usersData) {
      User newUser = User(user["name"]["first"] + user["name"]["last"],
          user["email"], user["picture"]["large"], user["phone"]);

      users.add(newUser);
    }

    return users;
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Users',
              style:
              TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
      body: Container(
        child: FutureBuilder(
            future: _getUsers(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.data == null) {
                return Container(
                  child: Center(
                    child: Text("Loading..."),
                  ),
                );
              } else {
                return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        onTap: () {
                          Navigator.push(
                              context,
                              new MaterialPageRoute(
                                  builder: (context) =>
                                      UserDetailPage(snapshot.data[index])));
                        },
                        title: Text(snapshot.data[index].fullName),
                        subtitle: Text(snapshot.data[index].mobileNumber),
                        leading: CircleAvatar(
                            backgroundImage:
                            NetworkImage(snapshot.data[index].imageUrl)),
                      );
                    });
              }
            }),
      ),
    );
  }
}

class User {
  final String fullName;

  final String email;

  final String imageUrl;

  final String mobileNumber;

  User(this.fullName, this.email, this.imageUrl, this.mobileNumber);
}

class UserDetailPage extends StatelessWidget {
  final User user;

  UserDetailPage(this.user);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(user.fullName),
      ),
    );
  }
}

