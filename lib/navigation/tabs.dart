import 'package:flutter/material.dart';
import './first_page.dart' as first;
import './second_page.dart' as second;
import './third_page.dart' as third;

// https://kodestat.gitbook.io/flutter/flutter-tab-navigation

void TabNavigation() {
  runApp(new MaterialApp(
      home: new MyTabs()
  ));
}

class MyTabs extends StatefulWidget{
  @override
  MyTabsState createState() => new MyTabsState();
}

class MyTabsState extends State<MyTabs> with SingleTickerProviderStateMixin{

  TabController controller;

  @override
  void initState(){
    super.initState();
    controller = new TabController(vsync: this, length: 3);
  }

  @override
  void dispose(){
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context){
    return new Scaffold(
        appBar: new AppBar(title: new Text("Pages"), backgroundColor: Colors.deepOrange,
            bottom: new TabBar(
                controller: controller,
                tabs: <Tab>[
                  new Tab(icon: new Icon(Icons.arrow_forward)),
                  new Tab(icon: new Icon(Icons.arrow_downward)),
                  new Tab(icon: new Icon(Icons.arrow_back))
                ]
            )
        ),
        bottomNavigationBar: new Material(
            color: Colors.deepOrange,
            child: new TabBar(
                controller: controller,
                tabs: <Tab>[
                  new Tab(icon: new Icon(Icons.arrow_forward)),
                  new Tab(icon: new Icon(Icons.arrow_downward)),
                  new Tab(icon: new Icon(Icons.arrow_back))
                ]
            )
        ),
        body: new TabBarView(
            controller: controller,
            children: <Widget>[
              new first.First(),
              new second.Second(),
              new third.Third()
            ]
        )
    );
  }
}
