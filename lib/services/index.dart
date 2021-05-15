import 'dart:convert';

import 'package:azlistview/azlistview.dart';
import 'package:flutter/foundation.dart';
import 'package:firm/cloud_sdk/index.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:lpinyin/lpinyin.dart';

part 'chat_service.dart';
part 'conversation_service.dart';
part 'contacts_service.dart';
part 'user_service.dart';
part 'add_friends_service.dart';
part 'new_friends_service.dart';
part 'login_service.dart';
part 'register_service.dart';
part 'group_manage_service.dart';
part 'mine_service.dart';

final ChatService chatService = ChatService();
final ConversationService conversationService = ConversationService();
final ContactsService contactsService = ContactsService();
final UserService userService = UserService();
