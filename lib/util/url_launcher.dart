import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void URLLauncher() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final title = 'URL Launcher List';

    return MaterialApp(
      title: title,
      home: Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: ListView(
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.open_in_browser),
              title: Text('Show URL Flutter homepage'),
              onTap: _launchURL,
            ),
            ListTile(
              leading: Icon(Icons.sms),
              title: Text('Send SMS'),
              onTap: _launchSMS,
            ),
            ListTile(
              leading: Icon(Icons.phone),
              title: Text('Call Phone'),
              onTap: _launchPhone,
            ),
            ListTile(
              leading: Icon(Icons.mail),
              title: Text('Send Email'),
              onTap: _launchMail,
            ),
          ],
        ),
      ),
    );
  }
}

_launchURL() async {
  const url = 'https://flutter.io';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

_launchMail() async {
  // mailto:<email address>?subject=<subject>&body=<body>
  const url =
      'mailto:pritamkhose1@gmail.com.org?subject=Fluuter%20Mail%20Subject&body=New%20plugin%20body';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch mail $url';
  }
}

_launchSMS() async {
  const url = 'sms:+919762752260';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch SMS $url';
  }
}

_launchPhone() async {
  const url = 'tel:+919762752260';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch Phone $url';
  }
}
