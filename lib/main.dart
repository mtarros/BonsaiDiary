import 'dart:core';
import 'package:flutter/material.dart';
import 'package:bonsai_diary/bonsai_page.dart';
//import 'package:bonsai_diary/bonsai_detail_page.dart';

void main() {
  // runApp(new MyApp());

  runApp(new MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: new ThemeData(
        primarySwatch: Colors.green,
        accentColor: Colors.green,
      ),
      home: new MyTabs()
//        routes: <String, WidgetBuilder> {
//          '/bonsai': (BuildContext context) => new BonsaiPage(),
//          '/bonsaiDetails': (BuildContext context) => new BonsaiDetailsPage(null)
//        },

      ));
}
//
//class MyApp extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//
//    return new MaterialApp(
//      theme: new ThemeData(
//        primarySwatch: Colors.green,
//        accentColor: Colors.green,
//      ),
//      home: new BonsaiPage(),
//    );
//  }
//}

class MyTabs extends StatefulWidget {
  @override
  MyTabState createState() => new MyTabState();
}

class MyTabState extends State<MyTabs> with SingleTickerProviderStateMixin {
  TabController controller;

  //var tabPageWidget = [new BonsaiPage(), new Text('Warning')];
  //int _index = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = new TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.white,
//      bottomNavigationBar: new BottomNavigationBar(
//        fixedColor: Colors.green,
//          currentIndex: _index,
//          onTap: (int selectedIndex){
//            setState(() {
//              _index = selectedIndex;
//            });
//          },
//          items: [
//            new BottomNavigationBarItem(
//                icon: new Icon(Icons.wallpaper),
//                backgroundColor: Colors.green,
//                title: new Text('Bonsai')
//            ),
//            new BottomNavigationBarItem(
//                icon: new Icon(Icons.warning),
//                title: new Text('Pots')
//            )
//          ]
//      ),

      // floatingActionButton: new FloatingActionButton(backgroundColor: Colors.lightGreen, onPressed: (){}, child: new Icon(Icons.add)),
      bottomNavigationBar: new Material(
          color: Colors.green,
          shadowColor: Colors.transparent,
          child: new TabBar(
              indicatorColor: Colors.lightGreen,
              controller: controller,
              tabs: <Tab>[
                new Tab(
                  icon: new Icon(Icons.wallpaper),
                  text: 'Bonsai',
                ),
                new Tab(
                  icon: new Icon(Icons.warning),
                  text: 'Pots',
                )
              ])),

      appBar: new AppBar(
        title: new Text('Bonsai Diary'),
        backgroundColor: Colors.green,
      ),

      //body: tabPageWidget[_index],
      body: new TabBarView(
        controller: controller,
        children: <Widget>[new BonsaiPage(), new Text('Warning')],
      ),
    );
  }
}
