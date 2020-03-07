import 'package:flutter/material.dart';

import 'package:flutter_todolist/home.dart';
import 'data.dart';
import 'global.dart';
import 'util.dart';

class Modal {
  final titleController = TextEditingController();
  final contentController = TextEditingController();

  int _noteIndex = 0;

  mainBottomSheet(BuildContext context, {int noteIndex=-1}) {
    _noteIndex = noteIndex;
    if(_noteIndex != -1){
      titleController.text = Global.getNoteList()[_noteIndex].title;
      contentController.text = Global.getNoteList()[_noteIndex].content;
    }
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height - 80,
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Stack(
            alignment: AlignmentDirectional.topCenter,
            children: <Widget>[
              Positioned(
                top: MediaQuery.of(context).size.height / 25,
                left: 0,
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.elliptical(175, 30),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: MediaQuery.of(context).size.height / 2 - 340,
                child: Container(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[

                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          SizedBox(height: 10),
                          Text('Title'),
                          Container(
                            width: MediaQuery.of(context).size.width / 1.2,
                            child: TextFormField(
                              controller: titleController,
                              autofocus: true,
                              maxLines: 1,
                              maxLength: 10,
                              style: TextStyle(
                                  fontSize: 22, fontStyle: FontStyle.normal),

                            ),
                          ),
                          SizedBox(height: 5),
                          Text('Content'),
                          Container(
                            width: MediaQuery.of(context).size.width / 1.2,
                            child: TextFormField(
                              controller: contentController,
                              autofocus: false,
                              maxLines: 8,
                              maxLength: 300,
                              style: TextStyle(
                                  fontSize: 16, fontStyle: FontStyle.normal),

                            ),
                          ),
                          SizedBox(height: 20),
                          RaisedButton(
                            onPressed: () {
                              if(_noteIndex != -1){
                                Global.getNoteList()[_noteIndex].title = titleController.text;
                                Global.getNoteList()[_noteIndex].content = contentController.text;
                              }
                              else{
                                Note note = Note();
                                note.type = 2;
                                note.title = titleController.text;
                                note.content = contentController.text;
                                note.checked = false;

                                Global.addNote(note);
                              }


                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) => Home()),
                              );
                              // Navigator.pop(context);
                            },
                            textColor: Colors.white,
                            padding: const EdgeInsets.all(0.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Container(
                              width: MediaQuery.of(context).size.width / 1.2,
                              height: 60,
                              decoration: const BoxDecoration(
                                gradient: LinearGradient(
                                  colors: <Color>[
                                    CustomColors.BlueLight,
                                    CustomColors.BlueDark,
                                  ],
                                ),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(8.0),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: CustomColors.BlueShadow,
                                    blurRadius: 2.0,
                                    spreadRadius: 1.0,
                                    offset: Offset(0.0, 0.0),
                                  ),
                                ],
                              ),
                              padding:
                                  const EdgeInsets.fromLTRB(20, 10, 20, 10),
                              child: Center(
                                child: const Text(
                                  'Add task',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                        ],
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          width: 50,
                          height: 50,
                          child: Image.asset('assets/images/fab-delete.png'),
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: <Color>[
                                CustomColors.PurpleLight,
                                CustomColors.PurpleDark,
                              ],
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(50.0),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: CustomColors.PurpleShadow,
                                blurRadius: 10.0,
                                spreadRadius: 5.0,
                                offset: Offset(0.0, 0.0),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
