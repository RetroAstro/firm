import 'package:flutter/material.dart';

class UserEntity {
  String avatar;
  String userName;
  String nickName;
  String company;
  String email;
  String phone;

  UserEntity({
    @required this.avatar,
    @required this.userName,
    @required this.nickName,
    @required this.company,
    @required this.email,
    @required this.phone,
  });
}
