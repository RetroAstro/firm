part of 'index.dart';

class MessageEntity {
  bool isSolo;
  bool isSender;
  bool isRichText;
  String avatar;
  String userName;
  String toUserName;
  String nickName;
  String content;
  String imgUrl;
  String rawImgUrl;
  String mediaPath;
  String createTimeFormat;
  int createTime;
  int voiceLength;
  int msgId;
  int msgType;
  List<String> richTextList;

  MessageEntity({
    @required this.isSolo,
    @required this.isSender,
    @required this.isRichText,
    @required this.avatar,
    @required this.userName,
    @required this.toUserName,
    @required this.nickName,
    @required this.content,
    @required this.imgUrl,
    @required this.rawImgUrl,
    @required this.mediaPath,
    @required this.createTime,
    @required this.createTimeFormat,
    @required this.voiceLength,
    @required this.msgId,
    @required this.msgType,
    @required this.richTextList,
  });
}

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

class UserEntity {
  String avatar;
  String userName;
  String nickName;

  UserEntity({
    @required this.avatar,
    @required this.userName,
    @required this.nickName,
  });
}
