import 'apis/add_friends/index.dart';
import 'apis/chat/index.dart';
import 'apis/contacts/index.dart';
import 'apis/conversation/index.dart';
import 'apis/group_manage/index.dart';
import 'apis/login/index.dart';
import 'apis/mine/index.dart';
import 'apis/new_friends/index.dart';
import 'apis/register/index.dart';
import 'apis/user/index.dart';

export 'package:firm/cloud_sdk/apis/user/entity.dart';
export 'package:firm/cloud_sdk/apis/chat/entity.dart';
export 'package:firm/cloud_sdk/apis/conversation/entity.dart';
export 'package:firm/cloud_sdk/apis/contacts/entity.dart';

class CloudSDK {
  UserAPI user = UserAPI();
  ChatAPI chat = ChatAPI();
  ConversationAPI conversation = ConversationAPI();
}

final CloudSDK cloudSDK = CloudSDK();
