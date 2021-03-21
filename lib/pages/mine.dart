import 'package:firm/components/edit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:firm/constants/index.dart';

class Mine extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final divider = Divider(height: 1, color: Color(AppColors.DividerColor));
    return Scaffold(
        appBar: AppBar(
          title: Text('个人信息'),
        ),
        body: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              GestureDetector(
                onTap: () {},
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        '头像',
                        style: TextStyle(
                          color: AppColors.AppTextBColor,
                          fontSize: 18,
                        ),
                      ),
                      Image.asset(
                        'assets/default_avatar.png',
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      ),
                    ],
                  ),
                ),
              ),
              divider,
              buildItem(key: '昵称', value: 'xxxx', isEdit: true),
              divider,
              buildItem(key: '企业组织', value: 'xxxx', isEdit: true),
              divider,
              buildItem(key: '邮箱', value: 'xxxxxxx'),
              divider,
              buildItem(key: '电话', value: 'xxxxxxxxxx'),
              divider,
            ],
          ),
        ));
  }

  Widget buildItem({String key, String value, bool isEdit = false}) {
    final context = useContext();
    final rowItem = Container(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            key,
            style: TextStyle(color: AppColors.AppTextBColor, fontSize: 18),
          ),
          Text(
            value,
            style: TextStyle(color: AppColors.AppTextGColor, fontSize: 18),
          ),
        ],
      ),
    );
    if (isEdit) {
      return GestureDetector(
        behavior: HitTestBehavior.translucent,
        child: rowItem,
        onTap: () {
          print('xxxx');
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => Edit(label: key, initialValue: 'xxxx'),
            ),
          );
        },
      );
    }
    return rowItem;
  }
}
