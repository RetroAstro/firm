import 'package:firm/constants/index.dart';
import 'package:flutter/material.dart';

class ContactsItem extends StatelessWidget {
  final Function handleTap;

  const ContactsItem({Key key, this.handleTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: handleTap,
      child: Container(
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(color: Color(AppColors.DividerColor), width: 1),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                Image.asset(
                  'assets/default_avatar.png',
                  width: 48,
                  height: 48,
                  fit: BoxFit.cover,
                ),
                Container(width: 15),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      '林不读',
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
                  color: Colors.blue,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
