import 'package:flutter/material.dart';
import 'package:leancloud_storage/leancloud.dart';
import 'package:server/storage/user.dart';

part 'entities.dart';
part 'middlewares.dart';
part 'translator.dart';

class CloudSDK {
  Map<String, String> _avatarMap = {};
  Map<String, String> get avatarMap => _avatarMap;

  UserEntity _userInfo;
  UserEntity get userInfo => _userInfo;

  Future<List<ConversationEntity>> fetchConversationList() async {}

  Future<List<MessageEntity>> fetchMessageList({
    String username,
    int msgId = 0,
  }) async {}

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
