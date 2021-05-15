import 'entity.dart';

class ConversationAPI {
  Future<void> deleteConversation(String conversationName) async {}

  Future<void> markConversationRead(String username) async {}

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
}
