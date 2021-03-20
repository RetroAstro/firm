import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firm/constants/index.dart';
import 'package:firm/components/input_area.dart';
import 'package:firm/components/chat_item.dart';
import 'package:firm/services/index.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart';

class Chat extends HookWidget {
  final ScrollController _listSC = ScrollController();
  final TextEditingController _textEC = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  void sendMessage() {
    var content = _textEC.text;
    _textEC.clear();
    _focusNode.unfocus();
    if (content.trim().isNotEmpty) {
      chatService.sendTextMessage(content);
    }
  }

  void scrollToBottom() {
    _listSC.animateTo(
      _listSC.position.maxScrollExtent,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<ChatService>(context);
    final chatItems = state.chatMap[state.currentChat] ?? [];

    useEffect(() {
      return () {
        _textEC.dispose();
        _listSC.dispose();
        _focusNode.dispose();
      };
    }, []);

    return WillPopScope(
      child: Scaffold(
        appBar: AppBar(
          title: Text(state.currentNickname),
        ),
        body: Column(
          children: <Widget>[
            state.fetchState == FetchState.fetching
                ? CupertinoActivityIndicator(animating: true)
                : SizedBox.shrink(),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  FocusManager.instance.primaryFocus?.unfocus();
                },
                child: ListView.builder(
                  controller: _listSC,
                  itemCount: chatItems.length,
                  reverse: true,
                  physics: AlwaysScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    final item = chatItems[index];
                    Widget timeWidget = SizedBox.shrink();
                    if (index == chatItems.length - 1) {
                      state.fetchHistory(item.msgId);
                      timeWidget = _buildTimeWidget(item.createTimeFormat);
                    } else {
                      // 当与上一条 msg createTime 相差 5分钟时 显示时间
                      final threshold = 5 * 60;
                      if (item.createTime - chatItems[index + 1].createTime >
                          threshold) {
                        timeWidget = _buildTimeWidget(item.createTimeFormat);
                      }
                    }
                    return Column(
                      children: [
                        timeWidget,
                        ChatItem(chatitem: item),
                      ],
                    );
                  },
                ),
              ),
            ),
            InputArea(
              controller: _textEC,
              onMessageSended: sendMessage,
              focusNode: _focusNode,
            )
          ],
        ),
      ),
      onWillPop: () {
        state.closeChat();
        Navigator.pop(context);
      },
    );
  }

  Widget _buildTimeWidget(String time) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Text(
        time,
        style: TextStyle(
          fontSize: 13,
          color: AppColors.AppTextGColor,
        ),
      ),
    );
  }
}
