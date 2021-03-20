import 'package:firm/pages/chat.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:firm/components/conversation_item.dart';
import 'package:firm/services/index.dart';
import 'package:provider/provider.dart';

class Conversation extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final state = Provider.of<ConversationService>(context);

    useEffect(() {
      conversationService.fetchConversationList();
    }, []);

    return Scaffold(
      appBar: AppBar(
        title: Text('Firm APP'),
      ),
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Chat()),
                    );
                  },
                  isActive: state.conversations[index].active,
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
                secondaryActions: [buildDeleteButton(index, state)],
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
