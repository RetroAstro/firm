import 'package:flutter/material.dart';
import 'package:leancloud_storage/leancloud.dart';
import 'package:firm/utils/load_config.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

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
    return MaterialApp(
      title: 'firm',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(title: 'IM APP'),
    );
  }
}

class HomePage extends HookWidget {
  final String title;

  HomePage({this.title});

  @override
  Widget build(BuildContext context) {
    final counter = useState(0);

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Text('${counter.value}'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => counter.value++,
        child: Icon(Icons.add),
      ),
    );
  }
}
