import 'package:flutter/material.dart';
import 'package:awareframework_core/awareframework_core.dart'; // 导入 awareframework_core.dart
import 'sensor_page.dart'; // 导入 sensor_page.dart

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // 确保 Flutter 绑定已初始化
  await AwareframeworkCore.initialize(); // 初始化 Aware Framework

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aware Framework Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MySensorPage(), // 使用 MySensorPage 作为首页
    );
  }
}
