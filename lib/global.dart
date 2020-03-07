import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import 'data.dart';

class Global{
  static NoteList noteList;
  static SharedPreferences _prefs;

  static addNote(Note note){
    noteList.memberList.add(note);
    saveProfile();
  }

  static removeNote(int position){
    noteList.memberList.removeAt(position);
    saveProfile();
  }

  static List<Note> getNoteList()=> noteList.memberList;

  static loadFromJson(){
    String data = _prefs.getString("data");
    noteList.fromJson(json.decode(data));
  }

  static Future init() async{
    _prefs = await SharedPreferences.getInstance();
    noteList = NoteList();
    var _profile = _prefs.getString("data");
    if (_profile != null) {
      try {
        List<dynamic> list = json.decode(_profile);
        noteList.fromJson(json.decode(_profile));
      } catch (e) {
        print(e);
      }
    }
  }

  static saveProfile() =>
      _prefs.setString("data", noteList.toJson());

}