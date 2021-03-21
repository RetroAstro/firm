import 'package:flutter/material.dart';
import 'package:leancloud_storage/leancloud.dart';
import 'package:provider/provider.dart';
import 'package:firm/utils/load_config.dart';
import 'package:firm/services/index.dart';
import 'package:firm/pages/register.dart';
import 'package:firm/pages/login.dart';
import 'package:firm/pages/conversation.dart';
import 'package:firm/pages/mine.dart';

void main() {
  runApp(FirmApp());
  loadConfig().then((config) {
    LeanCloud.initialize(
      config.appid,
      config.appkey,
      server: config.domain,
      queryCache: new LCQueryCache(),
    );
    LCLogger.setLevel(LCLogger.DebugLevel);
  });
}

class FirmApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: chatService),
        ChangeNotifierProvider.value(value: conversationService),
      ],
      child: MaterialApp(
        title: 'firm',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: Mine(),
      ),
    );
  }
}
