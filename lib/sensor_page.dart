import 'package:flutter/material.dart';
import 'package:awareframework_core/awareframework_core.dart'; // 导入 awareframework_core.dart
import 'api_service.dart'; // 导入 api_service.dart
import 'package:permission_handler/permission_handler.dart'; // 导入 permission_handler

class MySensorPage extends StatefulWidget {
  @override
  _MySensorPageState createState() => _MySensorPageState();
}

class _MySensorPageState extends State<MySensorPage> {
  String _sensorData = '未获取到数据'; // 用于显示的传感器数据
  late AwareSensor _sensor; // 声明 AwareSensor 实例

  @override
  void initState() {
    super.initState();
    requestPermissions(); // 请求权限
    _sensor = AwareSensor(AwareSensorConfig()); // 创建 AwareSensor 实例
    _startSensor(); // 启动传感器
  }

  // 请求传感器权限的方法
  Future<void> requestPermissions() async {
    var sensorStatus = await Permission.sensors.status;
    if (!sensorStatus.isGranted) {
      await Permission.sensors.request();
    }

    var activityStatus = await Permission.activityRecognition.status;
    if (!activityStatus.isGranted) {
      await Permission.activityRecognition.request();
    }
  }

  // 启动传感器并监听数据
  void _startSensor() {
    print("启动传感器...");
    _sensor.start().then((_) {
      // 监听传感器数据
      print("传感器启动成功，监听数据...");
      _sensor.sensoron(AwareSensorType.ACCELEROMETER).listen((data) {
        print("接收到数据: $data");
        setState(() {
          _sensorData = data.toString(); // 更新显示的数据
          ApiService.sendData(data); // 发送数据到后端
        });
      });
    }).catchError((error) {
      print('启动传感器失败: $error');
    });
  }

  @override
  void dispose() {
    _sensor.stop(); // 停止传感器（如果需要）
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('传感器数据'),
      ),
      body: Center(
        child: Text(_sensorData), // 显示传感器数据
      ),
    );
  }
}
