import 'package:flutter/material.dart';

class ConversationEntity {
  String avatar;
  String userName;
  String nickName;
  String conversationName;
  int msgType;
  String desc;
  String updateTime;
  int unreadCount;
  bool isRichText;
  List<String> richTextList;
  bool active = false;

  ConversationEntity({
    @required this.avatar,
    @required this.userName,
    @required this.nickName,
    @required this.conversationName,
    @required this.msgType,
    @required this.desc,
    @required this.updateTime,
    @required this.unreadCount,
    @required this.isRichText,
    @required this.richTextList,
    @required this.active,
  });
}
