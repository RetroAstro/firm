import 'entity.dart';

class ChatAPI {
  Future<void> sendTextMessage(String username, String content) async {}

  Future<void> sendImageMessage(String name, String path) async {}

  Future<void> sendVoiceMessage(
    String username,
    String filePath,
    int voiceLength,
  ) async {}

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
}
