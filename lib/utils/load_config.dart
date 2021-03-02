import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';

class Config {
  String appid;
  String appkey;
  String domain;

  Config({this.appid, this.appkey, this.domain});

  factory Config.fromJson(Map<String, dynamic> map) {
    return Config(
      appid: map['appid'],
      appkey: map['appkey'],
      domain: map['domain'],
    );
  }
}

Future<Config> loadConfig() async {
  final res = json.decode(await rootBundle.loadString('config.json'));
  return Config.fromJson(res);
}
