import 'dart:convert';

import 'package:azlistview/azlistview.dart';
import 'package:flutter/foundation.dart';
import 'package:firm/cloud_sdk/index.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:lpinyin/lpinyin.dart';

part 'chat_service.dart';
part 'conversation_service.dart';
part 'contacts_service.dart';

final ChatService chatService = ChatService();
final ConversationService conversationService = ConversationService();
final ContactsService contactsService = ContactsService();
