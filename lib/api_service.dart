import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String _baseUrl = "https://your-api-url.com"; // 替换为你的 API 地址

  // 发送传感器数据到后端
  static Future<void> sendData(dynamic sensorData) async {
    final url = Uri.parse('$_baseUrl/sensor-data');
    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'data': sensorData,
      }),
    );

    if (response.statusCode == 200) {
      print('数据发送成功');
    } else {
      print('数据发送失败: ${response.statusCode}');
    }
  }
}
