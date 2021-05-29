import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:firm/constants/index.dart';

class GroupMemberItem extends HookWidget {
  String name;
  String avatar;

  GroupMemberItem({
    @required this.name,
    @required this.avatar,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Flexible(
            child: Container(
              color: AppColors.AppBgColor,
            ),
            flex: 3,
          ),
          Flexible(
            child: Center(
              child: Text(name),
            ),
            flex: 1,
          )
        ],
      ),
    );
  }
}

class GroupManageItem extends HookWidget {
  String entryKey;
  String entryValue;

  GroupManageItem({
    @required this.entryKey,
    @required this.entryValue,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            color: Color(AppColors.DividerColor),
            width: 1,
          ),
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            entryKey,
            style: TextStyle(fontSize: 18, color: AppColors.AppTextBColor),
          ),
          Row(
            children: <Widget>[
              Text(
                entryValue,
                style: TextStyle(fontSize: 18, color: AppColors.AppTextGColor),
              ),
              Icon(
                Icons.arrow_forward_ios_rounded,
                color: AppColors.AppTextGColor,
              ),
            ],
          )
        ],
      ),
    );
  }
}

class GroupManage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.AppBgColor,
      appBar: AppBar(
        iconTheme: IconThemeData(color: AppColors.AppTextBColor),
        title: Text(
          '计算机网络课程群(5)',
          style: TextStyle(color: AppColors.AppTextBColor, fontSize: 20),
        ),
        backgroundColor: AppColors.AppBgColor,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Flexible(
            flex: 3,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: GridView.count(
                crossAxisCount: 4,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                children: List.generate(12, (index) {
                  return GroupMemberItem(name: '牛奥林', avatar: '');
                }),
              ),
            ),
          ),
          Flexible(
            flex: 4,
            child: Column(
              children: <Widget>[
                Container(height: 30),
                Column(
                  children: <Widget>[
                    GroupManageItem(entryKey: '群聊名称', entryValue: '计算机网络课程群'),
                    GroupManageItem(entryKey: '群备注', entryValue: '网络小分队'),
                    GroupManageItem(entryKey: '群公告', entryValue: ''),
                    GroupManageItem(entryKey: '群文件共享', entryValue: ''),
                    GroupManageItem(entryKey: '考勤打卡', entryValue: ''),
                  ],
                ),
                Container(height: 30),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    decoration: BoxDecoration(color: Colors.white),
                    child: Center(
                      child: Text(
                        '删除并退出',
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
