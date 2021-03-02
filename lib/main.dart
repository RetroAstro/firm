import 'package:flutter/material.dart';
import 'package:leancloud_storage/leancloud.dart';
import 'package:firm/utils/load_config.dart';

void main() {
  runApp(MyApp());
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

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'firm',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(title: 'IM APP'),
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Container(),
      ),
    );
  }
}
