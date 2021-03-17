import 'package:flutter/material.dart';
import 'package:leancloud_storage/leancloud.dart';
import 'package:server/storage/user.dart';

part 'entities.dart';

class CloudSDK {
  final String username;

  CloudSDK({this.username});
}

class RegisterErrorHandler {
  final Map<int, Function> handler = {};

  RegisterErrorHandler() {
    handler[202] = usernameError;
    handler[203] = emailError;
    handler[214] = mobileError;
  }

  void usernameError() {}
  void emailError() {}
  void mobileError() {}
}

void test() {
  register().catchError((e) {
    if (e is LCException) {
      final handle = RegisterErrorHandler().handler[e.code];
      handle();
    }
  });
}
