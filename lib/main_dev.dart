import 'package:flutter/material.dart';
import 'package:manageable/app_config.dart';
import 'package:manageable/main.dart';

void main() {
  var configuredApp = new AppConfig(
    appName: "Manageable Dev",
    flavorName: "development",
    apiBaseUrl: "https://my-json-server.typicode.com/hntan/demo/",
    child: new MyApp(),
  );

  runApp(configuredApp);
}