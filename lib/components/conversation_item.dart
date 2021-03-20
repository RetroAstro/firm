import 'package:flutter/material.dart';
import 'package:firm/constants/index.dart';
import 'package:firm/cloud_sdk/index.dart';

typedef TappedCallback = Function(BuildContext context, String value);

class ConversationItem extends StatelessWidget {
  final ConversationEntity conversation;
  final TappedCallback onConversationTapped;
  final bool isActive;

  ConversationItem({
    Key key,
    this.conversation,
    this.onConversationTapped,
    this.isActive,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onConversationTapped(context, conversation.userName),
      child: buildConversationItem(),
    );
  }

  Widget buildConversationItem() {
    return AnimatedContainer(
        duration: Duration(milliseconds: 300),
        curve: Curves.fastOutSlowIn,
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isActive ? AppColors.AppBgColor : Colors.white,
          border: Border(
            bottom: BorderSide(
              color: Color(AppColors.DividerColor),
              width: 1,
            ),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            buildUnreadItem(),
            Container(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    conversation.nickName,
                    style: TextStyle(
                      fontSize: 18,
                      color: AppColors.AppTextBColor,
                      fontWeight: FontWeight.w400,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Container(
                    height: 20,
                    alignment: Alignment.topLeft,
                    child: conversation.isRichText
                        ? buildRichText(conversation.richTextList)
                        : Text(
                            conversation.desc,
                            overflow: TextOverflow.ellipsis,
                            softWrap: false,
                            style: TextStyle(
                              fontSize: 14,
                              color: AppColors.AppTextGColor,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                  )
                ],
              ),
            ),
            Container(width: 16),
            Column(
              children: <Widget>[
                Text(
                  conversation.updateTime,
                  style: TextStyle(
                    fontSize: 13,
                    color: AppColors.AppTextGColor,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: 20)
              ],
            )
          ],
        ));
  }

  Widget buildRichText(List<String> list) {
    return Container();
  }

  Widget buildUnreadItem() {
    return Stack(
      overflow: Overflow.visible,
      children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: conversation.avatar == 'default'
              ? Image.asset(
                  'assets/default_avatar.png',
                  width: 48,
                  height: 48,
                  fit: BoxFit.cover,
                )
              : Image.network(
                  conversation.avatar,
                  width: 48,
                  height: 48,
                  fit: BoxFit.cover,
                ),
        ),
        Positioned(
          top: -3,
          right: -3,
          child: !isActive && conversation.unreadCount != 0
              ? Container(
                  width: 18,
                  height: 18,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color(AppColors.NotifyDotBg),
                  ),
                  child: Text(
                    conversation.unreadCount > 99
                        ? '...'
                        : conversation.unreadCount.toString(),
                    style: TextStyle(fontSize: 12, color: Colors.white),
                  ),
                )
              : Container(),
        )
      ],
    );
  }
}
