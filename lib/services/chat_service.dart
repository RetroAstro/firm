part of 'index.dart';

class ChatService with ChangeNotifier {
  String _currentChat = '';
  String _currentNickname = '';
  Map<String, List<MessageEntity>> _chatMap = {};
  bool _isChat = false;
  bool _isFetching = false;

  bool get isChat => _isChat;

  bool get isFetching => _isFetching;

  set isFetching(bool value) {
    if (value != isFetching) {
      _isFetching = value;
      notifyListeners();
    }
  }

  String get currentChat => _currentChat;

  String get currentNickname => _currentNickname;

  Map<String, List<MessageEntity>> get chatMap => _chatMap;

  void refresh() {
    notifyListeners();
  }

  void openChat(String username, String nickname) {
    _isChat = true;
    _currentChat = username;
    _currentNickname = nickname;
    if (_chatMap[_currentChat] == null) {
      _chatMap[_currentChat] = [];
    }
  }

  void closeChat() {
    _isChat = false;
    _isFetching = false;
    _currentChat = '';
    _currentNickname = '';
  }

  void clearChat() {
    closeChat();
    _chatMap.clear();
    refresh();
  }

  void joinChat(String conversationName, String nickName) {
    if (chatService.currentChat != conversationName) {
      chatService
        ..stopVoice()
        ..openChat(conversationName, nickName)
        ..fetchMessageList()
        ..refresh();
    }
  }

  Future fetchMessageList() async {
    if (_chatMap[_currentChat] != null && _chatMap[_currentChat].isEmpty) {
      isFetching = true;
      final list = await cloudSDK.fetchMessageList(username: _currentChat);
      isFetching = false;
      _chatMap[_currentChat].addAll(list);
    }
  }

  Future<bool> fetchHistory(int msgId) async {
    final list =
        await cloudSDK.fetchMessageList(username: _currentChat, msgId: msgId);
    if (list.length == 0) {
      return false;
    } else {
      _chatMap[_currentChat].addAll(list);
      refresh();
      return true;
    }
  }

  void sendTextMessage(String content) {
    cloudSDK.sendTextMessage(_currentChat, content);
  }

  void sendImageMessage(String name, String path) {
    cloudSDK.sendImageMessage(name, path);
  }

  void sendVoiceMessage({String filePath, int voiceLength}) {
    cloudSDK.sendVoiceMessage(_currentChat, filePath, voiceLength);
  }

  void receiveMessage(MessageEntity msg) {
    var key = msg.isSender ? msg.toUserName : msg.userName;
    if (_chatMap[key] != null) {
      for (var i = 0; i < _chatMap[key].length; i++) {
        if (_chatMap[key][i].msgId == msg.msgId) {
          _chatMap[key][i] = msg;
          return refresh();
        }
      }
      _chatMap[key].insert(0, msg);
      refresh();
    }
  }

  void playVoice(String path) async {
    stopVoice();
  }

  void stopVoice() {}
}
