import 'package:firm/pages/chat.dart';
import 'package:firm/services/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:firm/components/edit.dart';
import 'package:firm/constants/index.dart';

class User extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final divider = Divider(height: 1, color: Color(AppColors.DividerColor));
    return Scaffold(
      backgroundColor: AppColors.AppBgColor,
      appBar: AppBar(
        iconTheme: IconThemeData(color: AppColors.AppTextBColor),
        title: Text(
          '',
          style: TextStyle(color: AppColors.AppTextBColor),
        ),
        backgroundColor: AppColors.AppBgColor,
      ),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            decoration: BoxDecoration(color: Colors.white),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  'assets/default_avatar.png',
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                ),
                Container(width: 15),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      '风华雪域',
                      style: TextStyle(
                        fontSize: 18,
                        color: AppColors.AppTextBColor,
                      ),
                    ),
                    Text(
                      '昵称: 张三',
                      style: TextStyle(
                        fontSize: 13,
                        color: AppColors.AppTextGColor,
                      ),
                    ),
                    Text(
                      '企业组织：李四',
                      style: TextStyle(
                        fontSize: 13,
                        color: AppColors.AppTextGColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          divider,
          GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => Edit(label: '备注', initialValue: 'xxx'),
                ),
              );
            },
            child: Container(
              decoration: BoxDecoration(color: Colors.white),
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    '设置备注名',
                    style: TextStyle(
                      color: AppColors.AppTextBColor,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(height: 20),
          GestureDetector(
            onTap: () {
              chatService.joinChat('xxx', 'xxxxx');
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Chat()),
              );
            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 15),
              decoration: BoxDecoration(color: Colors.white),
              child: Center(
                child: Text(
                  '发消息',
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ),
          divider,
        ],
      ),
    );
  }
}
