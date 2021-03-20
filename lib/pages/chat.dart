import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firm/constants/index.dart';
import 'package:firm/components/input_area.dart';
import 'package:firm/components/chat_item.dart';
import 'package:firm/services/index.dart';

class Chat extends StatefulWidget {
  const Chat({Key key}) : super(key: key);

  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  final ScrollController _listSC = ScrollController();
  final TextEditingController _textEC = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _textEC.dispose();
    _listSC.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        buildChatList(),
      ],
    );
  }

  Widget buildChatList() {
    final chatItems = chatService.chatMap[chatService.currentChat] ?? [];
    return Column(
      children: <Widget>[
        chatService.isFetching
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
                  chatService.fetchHistory(item.msgId);
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
}
