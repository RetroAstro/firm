import 'package:flutter/material.dart';
import 'package:azlistview/azlistview.dart';

class ContactsEntity extends ISuspensionBean {
  final String avatar;
  final String userName;

  String tagIndex;

  ContactsEntity({
    @required this.avatar,
    @required this.userName,
  });

  @override
  String getSuspensionTag() => tagIndex;
}
