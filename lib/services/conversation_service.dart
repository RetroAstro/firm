part of 'index.dart';

class ConversationService with ChangeNotifier {
  List<ConversationEntity> _conversations = [];
  int _prevIndex = -1;

  List<ConversationEntity> get conversations => _conversations;

  cancelPrevActive(bool isChat) {
    if (_prevIndex != -1 && !isChat) {
      _conversations[_prevIndex].active = false;
      _prevIndex = -1;
      notifyListeners();
    }
  }

  clearConversations() {
    _conversations = [];
    _prevIndex = -1;
    notifyListeners();
  }

  tapConversation(String conversationName) {
    var index = 0;
    for (var i = 0; i < _conversations.length; i++) {
      if (_conversations[i].conversationName == conversationName) {
        index = i;
        break;
      }
    }
    if (_prevIndex == index) {
      return;
    }
    if (_prevIndex != -1) {
      _conversations[_prevIndex].active = false;
    }
    _conversations[index].active = true;
    _prevIndex = index;
    notifyListeners();
  }

  Future fetchConversationList(dynamic val) async {
    _conversations = [];
    // fetchConversationList()
    final List<ConversationEntity> list = [];
    list.forEach((item) {
      if (item.conversationName != 'userName') {
        _conversations.add(item);
      }
    });
    notifyListeners();
  }

  Future removeConversation(int index, String conversationName) async {
    // deleteConversation(conversationName);
    _conversations.removeAt(index);
    notifyListeners();
  }

  markConversationRead(String username) {
    if (username.isNotEmpty) {
      // markConversationRead(username);
    }
  }

  updateProps(ConversationEntity prev, ConversationEntity next) {
    prev
      ..msgType = next.msgType
      ..avatar = next.avatar
      ..desc = next.desc
      ..unreadCount = next.unreadCount
      ..updateTime = next.updateTime
      ..isRichText = next.isRichText
      ..richTextList = next.richTextList;
  }

  updateConversation(ConversationEntity conversation) {
    if (conversation.conversationName == 'userName') {
      return;
    }
    if (conversation.unreadCount == 0) {
      _conversations.forEach((item) {
        if (item.conversationName == conversation.conversationName) {
          updateProps(item, conversation);
        }
      });
    } else {
      ConversationEntity existConversation;

      for (var i = 0; i < _conversations.length; i++) {
        if (_conversations[i].conversationName ==
            conversation.conversationName) {
          existConversation = _conversations.removeAt(i);
        }
      }

      if (existConversation != null) {
        updateProps(existConversation, conversation);
      }

      _conversations.insert(0, existConversation ?? conversation);

      for (var i = 0; i < _conversations.length; i++) {
        if (_conversations[i].active) {
          _prevIndex = i;
        }
      }
    }
    notifyListeners();
  }

  setConversationUpdateListener() {
    // setConversationUpdateListener();
  }

  stopListenConversationManager() {
    // stopListenConversationManager();
  }
}
