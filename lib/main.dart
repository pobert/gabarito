import 'package:flutter/material.dart';
import 'package:flutter_app/app/my_appF.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';

void main() {
  setUrlStrategy(PathUrlStrategy());
  // rodando aplicação da classe MyAppF
  runApp(const MyAppf());
}
