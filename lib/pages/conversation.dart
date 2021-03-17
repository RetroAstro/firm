import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:firm/components/conversation_item.dart';
import 'package:firm/services/index.dart';
import 'package:provider/provider.dart';

class Conversation extends StatelessWidget {
  Conversation({Key key}) : super(key: key);

  bool isChat;

  @override
  Widget build(BuildContext context) {
    var state = Provider.of<ConversationService>(context);
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: <Widget>[
          ListView.builder(
            itemCount: state.conversations.length,
            itemBuilder: (context, int index) {
              return Slidable(
                key: Key(
                  'key_${state.conversations[index].conversationName.toString()}',
                ),
                child: ConversationItem(
                  conversation: state.conversations[index],
                  onConversationTapped: (context, value) {
                    chatService.joinChat(
                      state.conversations[index].conversationName,
                      state.conversations[index].nickName,
                    );
                  },
                ),
                dismissal: SlidableDismissal(
                  closeOnCanceled: false,
                  dragDismissible: true,
                  child: SlidableDrawerDismissal(),
                  onWillDismiss: (actionType) {
                    return false;
                  },
                  onDismissed: (_) {},
                ),
                actionPane: SlidableDrawerActionPane(),
                actionExtentRatio: 0.2,
                secondaryActions:
                    isChat ? [] : [buildDeleteButton(index, state)],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget buildDeleteButton(int index, ConversationService state) {
    return GestureDetector(
      child: Container(
        color: Colors.red,
        alignment: Alignment.center,
        child: Text(
          '删除',
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
      onTap: () {
        state.removeConversation(
          index,
          state.conversations[index].conversationName,
        );
      },
    );
  }
}
