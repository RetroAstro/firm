import 'package:flutter/material.dart';
import 'package:firm/cloud_sdk/index.dart';
import 'package:firm/constants/index.dart';

class ContactsItem extends StatelessWidget {
  final ContactsEntity contactsitem;
  final Function(BuildContext context, ContactsEntity item) handleTap;

  const ContactsItem({
    Key key,
    this.contactsitem,
    this.handleTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => handleTap(context, contactsitem),
      child: Container(
        height: 60,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(color: Color(AppColors.DividerColor), width: 1),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(width: 10),
                ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: Image.network(
                    contactsitem.avatar,
                    width: 42,
                    height: 42,
                    fit: BoxFit.cover,
                  ),
                ),
                Container(width: 15),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      contactsitem.userName,
                      style: TextStyle(
                          color: AppColors.AppTextBColor, fontSize: 16),
                    ),
                    Text(
                      '你好哈哈哈哈哈',
                      style: TextStyle(
                          color: AppColors.AppTextGColor, fontSize: 13),
                    ),
                  ],
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Container(
                  width: 10,
                  height: 10,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
