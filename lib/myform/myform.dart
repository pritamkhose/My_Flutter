import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'data.dart';
import 'myeditform.dart';
import 'sampleform.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Fetch Data JSON My List"),
        actions: <Widget>[
          IconButton(
            icon: new Icon(Icons.refresh),
            onPressed: () {
              _fetchData();
            },
          ),
          IconButton(
            icon: new Icon(Icons.menu),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SampleForm()),
              );
            },
          ),
        ],
//        leading: Builder(
//          builder: (context) => IconButton(
//                icon: new Icon(Icons.refresh),
//                onPressed: () => _fetchData(),
//              ),
//        ),
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : _showList(list),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => EditMyForm(null)),
          );
        },
        tooltip: 'New',
        child: Icon(Icons.add),
      ),
    );
  }

  _fetchData() async {
    try {
      setState(() {
        isLoading = true;
      });
      final response = await http.get(
          "http://ec2-13-232-4-223.ap-south-1.compute.amazonaws.com:8080/data/data");
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
        _ackAlert(
            context, 'Error', 'Http error' + ' - ' + response.body.toString());
        // throw Exception('Failed to load Data');
      }
    } on SocketException catch (_) {
      _ackAlert(context, 'Offline', 'No Ineternet available');
    } on Exception catch (e) {
      _ackAlert(context, 'Exception', e.toString());
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
}

_showList(list) {
  return Container(
    color: Colors.black12,
    padding: EdgeInsets.symmetric(horizontal: 5.0),
    child: ListView.builder(
      itemCount: list.length,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          child: ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 5.0),
            title: new Text(list[index].title.toUpperCase()),
            subtitle: new Text(list[index].descp.toString()),
            leading: CircleAvatar(
              backgroundImage: AssetImage("assets/360.png"),
            ),
            trailing: new Icon(Icons.edit, color: Colors.red),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => EditMyForm(list[index])),
              );
            },
          ),
        );
      },
    ),
  );
}
