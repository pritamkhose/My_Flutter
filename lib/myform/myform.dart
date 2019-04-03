import 'dart:convert';
import 'dart:io';

import 'data.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MyForm extends StatefulWidget {
  @override
  _MyFormState createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  List<Data> list = List();
  var isLoading = false;

  void initState() {
    super.initState();
    _fetchData();
  }

  _fetchData() async {
    try {
      setState(() {
        isLoading = true;
      });
      final response = await http.get(
          "http://ec2-13-233-244-150.ap-south-1.compute.amazonaws.com:8080/data/data");
      if (response.statusCode == 200) {
        list = (json.decode(response.body) as List)
            .map((data) => new Data.fromJson(data))
            .toList();
        setState(() {
          isLoading = false;
        });
      } else {
        setState(
              () {
            isLoading = false;
          },
        );
        _ackAlert(context, 'Error', 'Http error' + ' - ' + response.body.toString());
        throw Exception('Failed to load Data');
      }
    } on SocketException catch (_) {
      _ackAlert(context, 'Offline', 'No Ineternet available');
    }
  }

  // http://androidkt.com/flutter-alertdialog-example/
  Future<void> _ackAlert(BuildContext context, String title, String msg) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(msg),
          actions: <Widget>[
            FlatButton(
              child: Text('Reload'),
              onPressed: () {
                Navigator.of(context).pop();
                _fetchData();
              },
            ),
            FlatButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Fetch Data JSON My List"),
      ),
      body: isLoading
          ? Center(
        child: CircularProgressIndicator(),
      )
          : ListView.builder(
        itemCount: list.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            contentPadding: EdgeInsets.all(10.0),
            title: new Text(list[index].title),
            subtitle: new Text(list[index].descp.toString()),
          );
        },
      ),
    );
  }
}
