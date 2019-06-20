import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../codelab//styles.dart';

void AmazonClone() => runApp(Amazon());

const Color themeBackground = Color(0xFF232F3E); // Colors.indigo[800];
const Color themeBackground2 = Color(0xFF37475A);

class Amazon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Amazon',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: themeBackground,
      ),
      home: AmazonTabBar(),
    );
  }
}

class AmazonTabBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
          title: new Text("Amazon"),
          backgroundColor: themeBackground,
          actions: <Widget>[
            // action button
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                print('click on serach');
              },
            ),
            // action button
            IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () {
                print('click on cart');
              },
            ),
          ]),
      drawer: appDrawer(context),
      body: appBody,
    );
  }
}

appDrawer(context) {
  return new Drawer(
    child: new ListView(
      children: <Widget>[
        new Container(
          color: themeBackground,
          padding: EdgeInsets.symmetric(horizontal: 5.0),
          child: (new ListTile(
            title: new Text(
              "Hi, Pritam",
              style: new TextStyle(fontSize: 26.0, color: Colors.white),
            ),
            leading: new Icon(Icons.supervised_user_circle,
                size: 28.0, color: Colors.white),
            onTap: () {
              Navigator.of(context).pop();
            },
          )),
        ),
        new ListTile(
          title: new Text("Home"),
          onTap: () {
            Navigator.of(context).pop();
//                    Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) => new OtherPage("First Page")));
          },
        ),
        new ListTile(
          title: new Text("Shop By Category"),
          onTap: () {
            Navigator.of(context).pop();
//                    Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) => new OtherPage("Second Page")));
          },
        ),
        new ListTile(
          title: new Text("Today Deals"),
          onTap: () => Navigator.of(context).pop(),
        ),
        Divider(color: Colors.black54),
        new ListTile(
          title: new Text("Your Orders"),
          onTap: () => Navigator.of(context).pop(),
        ),
        new ListTile(
          title: new Text("Your Wish List"),
          onTap: () => Navigator.of(context).pop(),
        ),
        new ListTile(
          title: new Text("Your Account"),
          onTap: () => Navigator.of(context).pop(),
        ),
        new ListTile(
          title: new Text("Try Prime"),
          onTap: () => Navigator.of(context).pop(),
        ),
        new ListTile(
          title: new Text("Sell on"),
          onTap: () => Navigator.of(context).pop(),
        ),
        new ListTile(
          title: new Text("Program and Features"),
          trailing: new Icon(Icons.arrow_forward_ios),
          onTap: () => Navigator.of(context).pop(),
        ),
        Divider(color: Colors.black54),
        new ListTile(
          title: new Text(
            "#Contest",
            style:
                new TextStyle(fontStyle: FontStyle.italic, color: Colors.blue),
          ),
          trailing: new Icon(Icons.apps),
          onTap: () => Navigator.of(context).pop(),
        ),
        Divider(color: Colors.black54),
        new ListTile(
          title: new Text("Language A/क"),
          onTap: () => Navigator.of(context).pop(),
        ),
        new ListTile(
          title: new Text("Your Notification"),
          onTap: () => Navigator.of(context).pop(),
        ),
        new ListTile(
          title: new Text("Settings"),
          trailing: new Icon(Icons.arrow_forward_ios),
          onTap: () => Navigator.of(context).pop(),
        ),
        new ListTile(
          title: new Text("Customer Service"),
          onTap: () => Navigator.of(context).pop(),
        ),
      ],
    ),
  );
}

var appBody = new ListView(
  children: <Widget>[
    Container(
      padding: EdgeInsets.all(5),
      color: themeBackground,
      child: new DecoratedBox(
        decoration: BoxDecoration(
          color: Styles.searchBackground,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 4,
            vertical: 8,
          ),
          child: Row(
            children: [
              const Icon(
                CupertinoIcons.search,
                color: Styles.searchIconColor,
              ),
              Expanded(
                child: CupertinoTextField(
//                      controller: controller,
//                      focusNode: focusNode,
                  placeholder: "Search",
                  style: Styles.searchText,
                  cursorColor: Styles.searchCursorColor,
                ),
              ),
              GestureDetector(
//                    onTap: controller.clear,
                child: const Icon(
                  CupertinoIcons.photo_camera,
                  color: Styles.searchIconColor,
                ),
              ),
            ],
          ),
        ),
      ),
    ),
    Container(
      padding: EdgeInsets.all(5),
      color: themeBackground,
      child: new Padding(
        padding: const EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 10.0),
        child: Row(
          // https://medium.com/jlouage/flutter-row-column-cheat-sheet-78c38d242041
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Center(
              child: new Text("Prime",
                  style: new TextStyle(fontSize: 16.0, color: Colors.white)),
            ),
            Center(
              child: new Text("Grocery",
                  style: new TextStyle(fontSize: 16.0, color: Colors.white)),
            ),
            Center(
              child: new Text("Mobiles",
                  style: new TextStyle(fontSize: 16.0, color: Colors.white)),
            ),
            Center(
              child: new Text("Fashion",
                  style: new TextStyle(fontSize: 16.0, color: Colors.white)),
            )
          ],
        ),
      ),
    ),
    Container(
      color: themeBackground2,
      child: new Padding(
          padding: const EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
          child: Row(
            children: <Widget>[
              Container(
                child: new IconButton(
                    icon: new Icon(
                      Icons.location_on,
                      color: Colors.white,
                    ),
                    onPressed: null),
              ),
              Text("Deliver to Pritam .... 411044",
                  style: new TextStyle(fontSize: 15.0, color: Colors.white)),
              Container(
                child: new IconButton(
                    icon: new Icon(
                      Icons.keyboard_arrow_down,
                      color: Colors.white,
                    ),
                    onPressed: null),
              ),
            ],
          )),
    ),
    new Card(
      child: Column(
        children: <Widget>[
          Image.asset('assets/amazon1.png'),
        ],
      ),
    ),
    new Card(
      child: Column(
        children: <Widget>[
          Image.asset('assets/amazon2.png'),
        ],
      ),
    ),
    new Card(
      child: Column(
        children: <Widget>[
          Text(
            "Related to items you viewed",
            style: new TextStyle(fontSize: 20.0),
            textAlign: TextAlign.left,
          ),
          gridView,
        ],
      ),
    ),
    new Card(
      child: Column(
        children: <Widget>[
          Text(
            "Additional items to explore",
            style: new TextStyle(fontSize: 20.0),
            textAlign: TextAlign.left,
          ),
          gridView2,
        ],
      ),
    ),
    new Center(
      child: new Text("Load more ...", style: new TextStyle(fontSize: 12.0)),
    ),
  ],
);

// https://flutter.dev/docs/cookbook/lists/mixed-list
// https://github.com/vignesh7501/Flutter-ListView-and-GridView/blob/master/lib/main.dart
// https://medium.com/jlouage/flutter-boxdecoration-cheat-sheet-72cedaa1ba20
var gridView = new GridView.builder(
//  scrollDirection: Axis.vertical,
  padding: EdgeInsets.all(5),
  shrinkWrap: true,
  itemCount: 4,
  gridDelegate:
      new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
  itemBuilder: (BuildContext context, int index) {
    return new GestureDetector(
      child: new Card(
        elevation: 5.0,
        child: new Container(
          padding: EdgeInsets.all(5),
          child: Column(
            children: <Widget>[
              Image.asset(
                'assets/' + (index + 1).toString() + '.jpg',
                height: 110,
                width: 110,
              ),
              Text(
                'Picture ' + (index + 1).toString(),
                style: new TextStyle(fontSize: 16.0),
                textAlign: TextAlign.left,
              ),
              Row(
                children: <Widget>[
                  Text(
                    '   ₹ ' + (index + 1).toString() + '00    ',
                    style: new TextStyle(
                        fontSize: 16.0, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.left,
                  ),
                  Text(
                    '₹ ' + (index + 1).toString() + '97',
                    style: new TextStyle(
                        fontSize: 16.0,
                        color: Colors.grey,
                        decoration: TextDecoration.lineThrough),
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      onTap: () {},
    );
  },
);

// https://stackoverflow.com/questions/49402837/flutter-overlay-card-widget-on-a-container
var gridView2 = new GridView.builder(
//  scrollDirection: Axis.vertical,
  padding: EdgeInsets.all(5),
  shrinkWrap: true,
  itemCount: 6,
  gridDelegate:
      new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
  itemBuilder: (BuildContext context, int index) {
    return new GestureDetector(
      child: new Card(
        elevation: 5.0,
        child: new Container(
          padding: EdgeInsets.all(5),
          child: new Stack(
            children: <Widget>[
              Container(
               /* decoration: new BoxDecoration(
                  color: Colors.green,
                  borderRadius: new BorderRadius.only(
                      topLeft: const Radius.circular(10.0),
                      topRight: const Radius.circular(10.0),
                      bottomLeft: const Radius.circular(10.0),
                      bottomRight: const Radius.circular(10.0)),
                ),*/
                color: Colors.redAccent,
                child: Text(
                  '0' + (index + 4).toString() + '%\n off  ',
                  style: new TextStyle(fontSize: 12.0, color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ),
              Column(
                children: <Widget>[
                  Image.asset(
                    'assets/' + (index + 4).toString() + '.jpg',
                    height: 110,
                    width: 110,
                  ),
                  Text(
                    'Moive ' + (index + 4).toString(),
                    style: new TextStyle(fontSize: 16.0),
                    textAlign: TextAlign.left,
                  ),
                  Row(
                    children: <Widget>[
                      Text(
                        '   ₹ 2' + (index + 4).toString() + '99    ',
                        style: new TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.left,
                      ),
                      Text(
                        '₹ 3' + (index + 4).toString() + '99',
                        style: new TextStyle(
                            fontSize: 16.0,
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough),
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      onTap: () {},
    );
  },
);
