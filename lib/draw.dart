import 'package:flutter/material.dart';

import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:flutter_todolist/appBars.dart';
import 'package:flutter_todolist/bottomNavigation.dart';
import 'package:flutter_todolist/fab.dart';
import 'package:flutter_todolist/util.dart';
import 'package:whiteboardkit/whiteboardkit.dart';

import 'bottomSheet.dart';
import 'data.dart';
import 'global.dart';

class Draw extends StatefulWidget {
  Draw({Key key}) : super(key: key);

  _DrawState createState() => _DrawState();
}

class _DrawState extends State<Draw> {
  GestureWhiteboardController controller;
  final bottomNavigationBarIndex = 1;
  _DrawState(){

  }


  @override
  void initState() {
    controller = new GestureWhiteboardController();
    controller.onChange().listen((draw){
      //do something with it
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: emptyAppbar('Draw'),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Whiteboard(
                controller: controller,
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: customFab(context),
      bottomNavigationBar:
          BottomNavigationBarApp(context, bottomNavigationBarIndex),
    );

  }
}
