import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';

import 'data.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SampleForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sample Form"),
      ),
      body: SampleFormStateful(),
    );
  }
}

class SampleFormStateful extends StatefulWidget {
  @override
  _SampleFormState createState() => _SampleFormState();
}

class _SampleFormState extends State<SampleFormStateful> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var isLoading = false;
  final Data data = null;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10.0),
      child: _bulidContentPage(context),
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

    List<String> items = <String>['A item', 'B item', 'C item', 'D item'];
    Map<String, bool> values = {
      'foo': true,
      'bar': false,
    };

    return Form(
      key: _formKey,
      child: ListView(
        padding: EdgeInsets.symmetric(horizontal: targetPadding / 2),
        children: <Widget>[
          Container(
            child: TextFormField(
              maxLines: 1,
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
            child: DropdownButton<String>(
              value: items[0],
              items: items.map((String value) {
                return new DropdownMenuItem<String>(
                  value: value,
                  child: new Text(value),
                );
              }).toList(),
              onChanged: (String value) {
                print('DropdownButton --> ' + value);
              },
            ),
          ),
          // https://stackoverflow.com/questions/50060276/flutter-custom-radio-button
          // https://pub.dev/packages/grouped_buttons#-example-tab-
          // https://codingwithjoe.com/building-forms-with-flutter/
          new TextFormField(
            decoration: const InputDecoration(
              icon: const Icon(Icons.person),
              hintText: 'Enter your first and last name',
              labelText: 'Name',
            ),
          ),
          new TextFormField(
            decoration: const InputDecoration(
              icon: const Icon(Icons.calendar_today),
              hintText: 'Enter your date of birth',
              labelText: 'Dob',
            ),
            keyboardType: TextInputType.datetime,
          ),
          new TextFormField(
            decoration: const InputDecoration(
              icon: const Icon(Icons.phone),
              hintText: 'Enter a phone number',
              labelText: 'Phone',
            ),
            keyboardType: TextInputType.phone,
            inputFormatters: [
              WhitelistingTextInputFormatter.digitsOnly,
            ],
          ),
          new TextFormField(
            decoration: const InputDecoration(
              icon: const Icon(Icons.email),
              hintText: 'Enter a email address',
              labelText: 'Email',
            ),
            keyboardType: TextInputType.emailAddress,
          ),
          /*new FormField(
            builder: (FormFieldState state) {
              return InputDecorator(
                decoration: InputDecoration(
                  icon: const Icon(Icons.color_lens),
                  labelText: 'Color',
                ),
                isEmpty: _color == '',
                child: new DropdownButtonHideUnderline(
                  child: new DropdownButton(
                    value: _color,
                    isDense: true,
                    onChanged: (String newValue) {
                      setState(() {
                        newContact.favoriteColor = newValue;
                        _color = newValue;
                        state.didChange(newValue);
                      });
                    },
                    items: _colors.map((String value) {
                      return new DropdownMenuItem(
                        value: value,
                        child: new Text(value),
                      );
                    }).toList(),
                  ),
                ),
              );
            },
          ),*/
          SizedBox(
            height: 10.0,
          ),
          new Container(
            padding: const EdgeInsets.only(left: 40.0, top: 20.0),
            child: new RaisedButton(
              child: const Text('Submit'),
              onPressed: null,
            ),
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

    _ackAlert(context, 'On Save', formData.toString());
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
