import 'package:flutter/material.dart';

import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:flutter_todolist/appBars.dart';
import 'package:flutter_todolist/bottomNavigation.dart';
import 'package:flutter_todolist/fab.dart';
import 'package:flutter_todolist/util.dart';

import 'bottomSheet.dart';
import 'data.dart';
import 'global.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final bottomNavigationBarIndex = 0;


  _HomeState(){

  }


  

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: emptyAppbar('Note'),
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: Global.getNoteList().length,
          itemBuilder: (BuildContext context, int position){
            return GestureDetector(
                child:getItem(position),
                onTap: ()=>clickItem(position),
            );
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: customFab(context),
      bottomNavigationBar:
          BottomNavigationBarApp(context, bottomNavigationBarIndex),
    );

  }

  getItem(int position){
    Note subject = Global.getNoteList()[position];
    var row = null;

    if(subject.type == 1){
      row = Container(
        margin: EdgeInsets.only(top: 15, left: 20, bottom: 15),
        child: Text(
          'Today',
          style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: CustomColors.TextSubHeader),
        ),
      );

    }
    else{
      row = Slidable(
          actionPane: SlidableDrawerActionPane(),
          actionExtentRatio: 0.25,
          child: Container(
            margin: EdgeInsets.fromLTRB(20, 0, 20, 15),
            padding: EdgeInsets.fromLTRB(5, 13, 5, 13),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[

                Text(
                  'Title',
                  style: TextStyle(color: CustomColors.TextGrey),
                ),
                Container(
                  width: 280,
                  child: Text(
                    subject.title,
                    style: TextStyle(

                        color: CustomColors.TextHeader,
                        fontWeight: FontWeight.w800),
                  ),
                ),

              ],
            ),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                stops: [0.015, 0.015],
                colors: [CustomColors.GreenIcon, Colors.white],
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(5.0),
              ),
              boxShadow: [
                BoxShadow(
                  color: CustomColors.GreyBorder,
                  blurRadius: 10.0,
                  spreadRadius: 5.0,
                  offset: Offset(0.0, 0.0),
                ),
              ],
            ),
          ),
          secondaryActions: <Widget>[
                SlideAction(
                  child: Container(
                    padding: EdgeInsets.only(bottom: 10),
                    child: Container(
                      height: 35,
                      width: 35,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: CustomColors.TrashRedBackground),
                      child: Image.asset('assets/images/trash.png'),
                    ),
                  ),
                  onTap: () => delItem(position),
                ),
              ],
      );
    }
    return row;
  }

  delItem(int position){
    setState(() {
      Global.removeNote(position);
    });

  }
  clickItem(var position){
    Modal modal = Modal();

    modal.mainBottomSheet(context, noteIndex: position);

//    setState(() {
//      Global.getNoteList()[position].checked = !Global.getNoteList()[position].checked;
//    });
  }
}
