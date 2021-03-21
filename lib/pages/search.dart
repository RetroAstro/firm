import 'package:firm/components/contacts_item.dart';
import 'package:firm/pages/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:firm/constants/index.dart';

class Search extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final controller = useTextEditingController();
    return Scaffold(
      backgroundColor: AppColors.AppBgColor,
      appBar: AppBar(
        title: Text('添加朋友'),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(15),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(6),
              ),
              child: TextField(
                controller: controller,
                decoration: InputDecoration(
                  hintText: '昵称 / 用户名 / 手机号',
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 15),
                ),
                onSubmitted: (value) {},
              ),
            ),
          ),
          Container(height: 15),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: 3,
              itemBuilder: (context, int index) {
                return ContactsItem(
                  key: Key('key_$index'),
                  handleTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => User()),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
