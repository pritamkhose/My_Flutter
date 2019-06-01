import 'dart:convert';
import 'dart:io';

import 'data.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class EditMyForm extends StatelessWidget {
  Data mdata;
  EditMyForm(this.mdata);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit My Form"),
      ),
      body: MyEditForm(mdata),
    );
  }
}

class MyEditForm extends StatefulWidget {
  Data data;
  MyEditForm(this.data);

  @override
  _MyEditFormState createState() => _MyEditFormState(data);
}

class _MyEditFormState extends State<MyEditForm> {
  final Data data;

  _MyEditFormState(this.data);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  var isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10.0),
      child: isLoading
          ? Center(
        child: CircularProgressIndicator(),
      )
          : _bulidContentPage(context),
    );
  }

  _bulidContentPage(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double targetWidth = deviceWidth > 550.0 ? 500.0 : deviceWidth * 0.95;
    final double targetPadding = deviceWidth - targetWidth;

    final Map<String, dynamic> _formData = {
      'id': null,
      'title': null,
      'descp': null,
      'phone': null,
      'pin': null
//      'image': 'assets/food.jpg'
    };

    return Form(
      key: _formKey,
      child: ListView(
        padding: EdgeInsets.symmetric(horizontal: targetPadding / 2),
        children: <Widget>[
          Container(
            child: TextFormField(
              enabled: false,
              decoration: InputDecoration(labelText: 'ID'),
              initialValue: data == null ? '' : data.id.toString(),
              validator: (String value) {},
              onSaved: (String value) {
                if (value != null && value.length > 0) {
                  _formData['id'] = int.parse(value);
                } else {
                  _formData['id'] = 0;
                }
              },
            ),
          ),
          Container(
            child: TextFormField(
              decoration: InputDecoration(labelText: 'Title'),
              initialValue: data == null ? '' : data.title,
              validator: (String value) {
                if (value.isEmpty || value.length < 5) {
                  return 'Title is required and should be 5+ characters long.';
                }
              },
              onSaved: (String value) {
                _formData['title'] = value;
              },
            ),
          ),
          Container(
            child: TextFormField(
              maxLines: 4,
              decoration: InputDecoration(labelText: 'Description'),
              initialValue: data == null ? '' : data.descp,
              validator: (String value) {
                if (value.isEmpty || value.length < 5) {
                  return 'Description is required and should be 5+ characters long.';
                }
              },
              onSaved: (String value) {
                _formData['descp'] = value;
              },
            ),
          ),
          Container(
            child: TextFormField(
              maxLength: 12,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(labelText: 'Phone'),
              initialValue: data == null ? '' : data.phone.toString(),
              validator: (String value) {
                if (value.isEmpty || value.length < 6) {
                  return 'Phone is required and should be 6+ characters long.';
                }
              },
              onSaved: (String value) {
                _formData['phone'] = int.parse(value);
              },
            ),
          ),
          Container(
            child: TextFormField(
              maxLength: 6,
              keyboardType: TextInputType.numberWithOptions(
                  decimal: false, signed: false),
              decoration: InputDecoration(labelText: 'Pin'),
              initialValue: data == null ? '' : data.pin.toString(),
              validator: (String value) {
                if (value.isEmpty || value.length < 4) {
                  return 'Pin is required and 4 characters long.';
                }
              },
              onSaved: (String value) {
                _formData['pin'] = int.parse(value);
                ;
              },
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
//          GestureDetector(
//            onTap: _submitForm,
//            child: Container(
//              color: Colors.green,
//              padding: EdgeInsets.all(5.0),
//              child: Text('Save'),
//            ),
//          ),
          RaisedButton(
            color: Colors.green,
            onPressed: () {
              _saveData(_formData);
            },
            child: Text('Save'),
          ),
          RaisedButton(
            color: Colors.redAccent,
            onPressed: () {
              _deleteData(_formData);
            },
            child: Text('Delete'),
          ),
          RaisedButton(
            color: Theme.of(context).accentColor,
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Cancel'),
          ),
        ],
      ),
    );
  }

  void _saveData(Map<String, dynamic> formData) async {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
    print('--> ' + formData.toString());

    if (formData['id'] == null || formData['id'] == 0) {
      formData.remove('id');
    }

    try {
      setState(() {
        isLoading = true;
      });

      Map<String, String> header = {'Content-Type': 'application/json'};

      print('--> ' + formData.toString());

      final response = await http.post(
        "http://ec2-13-232-4-223.ap-south-1.compute.amazonaws.com:8080/data/data",
        headers: header,
        body: json.encode(formData),
      );
      //  if (data.id == null || data.id == 0){}
      if (response.statusCode == 200) {
        setState(() {
          isLoading = false;

//            Map data =Data.fromJson(json.decode(response.body)) as Map;
//          Data dObj = (json.decode(response.body).cast<Map<String, dynamic>>())
//              .map((data) => new Data.fromJson(data));
//          print('--> ' + dObj.toString());

          // https://flutter.dev/docs/cookbook/design/snackbars
          final snackBar = SnackBar(
            content: Text('Saved Sucessfully!'),
/*            action: SnackBarAction(
              label: 'Retry',
              onPressed: () {
                _saveData(formData);
              },
            ),*/
          );
          // Find the Scaffold in the Widget tree and use it to show a SnackBar!
          Scaffold.of(context).showSnackBar(snackBar);
        });
      } else {
        setState(
              () {
            isLoading = false;
          },
        );
        _ackAlert(
            context, 'Error', 'Http error' + ' - ' + response.body.toString());
      }
    } on SocketException catch (_) {
      _ackAlert(context, 'Offline', 'No Ineternet available');
    } on Exception catch (e) {
      _ackAlert(context, 'Exception', e.toString());
    }
  }

  void _deleteData(Map<String, dynamic> formData) async {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();

    try {
      setState(() {
        isLoading = true;
      });

      Map<String, String> header = {'Content-Type': 'application/json'};

      print('--> ' + formData.toString());

      final response = await http.delete(
        "http://ec2-13-232-4-223.ap-south-1.compute.amazonaws.com:8080/data/data/"+ formData['id'],
        headers: header,
      );
      //  if (data.id == null || data.id == 0){}
      if (response.statusCode == 200) {
        setState(() {
          isLoading = false;
          Navigator.of(context).pop();
        });
      } else {
        setState(
              () {
            isLoading = false;
          },
        );
        _ackAlert(
            context, 'Error', 'Http error' + ' - ' + response.body.toString());
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
