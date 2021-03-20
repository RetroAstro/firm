import 'package:flutter/material.dart';
import 'package:firm/constants/index.dart';
import 'package:firm/cloud_sdk/index.dart';
import 'message_item.dart';

class ChatItem extends StatelessWidget {
  final MessageEntity chatitem;

  bool get isSender => chatitem?.isSender;

  ChatItem({Key key, this.chatitem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Row(
        mainAxisAlignment:
            isSender ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          isSender ? buildContent() : buildAvatar(),
          Container(width: 10),
          isSender ? buildAvatar() : buildContent(),
        ],
      ),
    );
  }

  Widget buildAvatar() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(6),
      child: (chatitem.avatar == 'default' && !isSender)
          ? Image.asset(
              'assets/icon/default_avatar.png',
              width: 42,
              height: 42,
              fit: BoxFit.cover,
            )
          : Image.network(
              isSender ? cloudSDK.userInfo.avatar : chatitem.avatar,
              width: 42,
              height: 42,
              fit: BoxFit.cover,
            ),
    );
  }

  Widget buildContent() {
    return Flexible(
      flex: 3,
      child: Column(
        crossAxisAlignment:
            isSender ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: <Widget>[
          (chatitem.isSolo || isSender)
              ? Container()
              : Text(
                  chatitem.nickName,
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.AppTextGColor,
                  ),
                ),
          widgetMap[chatitem.msgType](chatitem) ?? buildUnknownItem(chatitem),
        ],
      ),
    );
  }
}
