import 'package:flutter/material.dart';
import 'package:manageable/app_config.dart';
import 'package:manageable/main.dart';

void main() {
  var configuredApp = new AppConfig(
    appName: "Manageable",
    flavorName: "production",
    apiBaseUrl: "http://192.168.1.95:8080/",
    child: new MyApp(),
  );

  runApp(configuredApp);
}