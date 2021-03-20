import 'package:flutter/material.dart';
import 'package:leancloud_storage/leancloud.dart';
import 'package:server/storage/user.dart';

part 'entities.dart';
part 'middlewares.dart';
part 'translator.dart';

class CloudSDK {
  Map<String, String> _avatarMap = {};
  Map<String, String> get avatarMap => _avatarMap;

  UserEntity _userInfo = UserEntity(
    avatar: 'default',
    userName: 'Alice',
    nickName: '王五',
  );

  UserEntity get userInfo => _userInfo;

  Future<List<ConversationEntity>> fetchConversationList() async {
    List<ConversationEntity> list = [];
    for (var i = 0; i < 10; i++) {
      list.add(
        ConversationEntity(
          avatar: 'default',
          userName: 'RetroAstro_$i',
          nickName: '张三_$i',
          conversationName: 'xxxx_$i',
          msgType: 1,
          desc: '_$i',
          updateTime: '12:30 _$i',
          unreadCount: i,
          isRichText: false,
          richTextList: [''],
          active: false,
        ),
      );
    }
    return list;
  }

  Future<List<MessageEntity>> fetchMessageList({
    String username,
    int msgId = 0,
  }) async {
    List<MessageEntity> list = [];
    for (var i = 0; i < 10; i++) {
      list.add(
        MessageEntity(
          isSolo: true,
          isSender: i % 2 == 0,
          isRichText: false,
          avatar: 'default',
          userName: i % 2 == 0 ? 'RetroAstro' : 'Barry',
          toUserName: i % 2 == 0 ? 'Barry' : 'RetroAstro',
          nickName: i % 2 == 0 ? '张三' : '李四',
          content: 'xxxxxxx 哈哈哈 $i',
          imgUrl: 'xxx',
          rawImgUrl: 'xxx',
          mediaPath: 'xxxxx',
          createTime: 12313,
          createTimeFormat: '12:31_$i',
          voiceLength: 7,
          msgId: 23131,
          msgType: 1,
          richTextList: [''],
        ),
      );
    }
    return list;
  }

  Future<void> sendTextMessage(String username, String content) async {}

  Future<void> sendImageMessage(String name, String path) async {}

  Future<void> sendVoiceMessage(
    String username,
    String filePath,
    int voiceLength,
  ) async {}

  Future<void> deleteConversation(String conversationName) async {}

  Future<void> markConversationRead(String username) async {}
}

class RegisterErrorHandler {
  final Map<int, Function> handler = {};

  RegisterErrorHandler() {
    handler[202] = usernameError;
    handler[203] = emailError;
    handler[214] = mobileError;
  }

  void usernameError() {}
  void emailError() {}
  void mobileError() {}
}

void test() {
  register().catchError((e) {
    if (e is LCException) {
      final handle = RegisterErrorHandler().handler[e.code];
      handle();
    }
  });
}

final CloudSDK cloudSDK = CloudSDK();
