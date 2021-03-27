import 'package:firm/components/contacts_item.dart';
import 'package:firm/constants/index.dart';
import 'package:firm/services/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart';

class NewFriends extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final state = Provider.of<ContactsService>(context);
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: AppColors.AppTextBColor),
        title: Text(
          '新的朋友',
          style: TextStyle(color: AppColors.AppTextBColor),
        ),
        backgroundColor: AppColors.AppBgColor,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: state.contactsList.length,
              itemBuilder: (context, index) {
                return ContactsItem(
                  contactsitem: state.contactsList[index],
                  handleTap: (context, item) {},
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
