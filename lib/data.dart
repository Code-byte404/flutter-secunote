import 'dart:convert';

class NoteList {
  List<Note> memberList;

  NoteList(){
    this.memberList = List();
  }



   fromJson(List<dynamic> listJson) {

    List<Note> memberList =
    listJson.map((value) => Note.fromJson(value)).toList();

    this.memberList = memberList;
  }

  String toJson(){
    return jsonEncode(memberList);
  }

}

class Note {
  int type;
  bool checked;
  String title ;
  String content;

  Note({this.type, this.checked, this.title, this.content});

  factory Note.fromJson(Map<String, dynamic> json) {
    return Note(type: json['type'], checked: json['checked'],title: json['title'],content: json['content']);
  }

  Map<String, dynamic> toJson() => {
    'type':type,
    'checked':checked,
    'title':title,
    'content':content
  };
}

