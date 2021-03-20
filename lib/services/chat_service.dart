part of 'index.dart';

enum FetchState {
  init,
  fetching,
  success,
  failed,
  nomore,
}

class ChatService with ChangeNotifier {
  String _currentChat = '';
  String get currentChat => _currentChat;

  String _currentNickname = '';
  String get currentNickname => _currentNickname;

  FetchState _fetchState = FetchState.init;
  FetchState get fetchState => _fetchState;

  bool _isChat = false;
  bool get isChat => _isChat;

  Map<String, List<MessageEntity>> _chatMap = {};
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
    _currentChat = '';
    _currentNickname = '';
    _fetchState = FetchState.init;
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
      final list = await cloudSDK.fetchMessageList(username: _currentChat);
      _chatMap[_currentChat].addAll(list);
    }
  }

  Future<void> fetchHistory(int msgId) async {
    if (_fetchState == FetchState.fetching ||
        _fetchState == FetchState.nomore) {
      return;
    }
    _fetchState = FetchState.fetching;
    try {
      final list =
          await cloudSDK.fetchMessageList(username: _currentChat, msgId: msgId);
      _fetchState = FetchState.success;
      if (list.isEmpty) {
        _fetchState = FetchState.nomore;
      } else {
        _chatMap[_currentChat].addAll(list);
        notifyListeners();
      }
    } catch (e) {
      _fetchState = FetchState.failed;
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
