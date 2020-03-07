import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter_todolist/global.dart';
import 'dart:convert';

import 'data.dart';


Future<String> _loadMemberJson(String noteString) async {
  return await rootBundle.loadString(noteString);
}

Future<NoteList> decodeMemberList(String noteString) async {
  String memberListJson = await _loadMemberJson(noteString);

  List<dynamic> list = json.decode(memberListJson);

  NoteList memberList;

//  memberList.memberList
//      .forEach((member) => print('member name is ${member.name}'));

  return memberList;
}