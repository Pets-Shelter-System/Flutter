import 'package:flutter/material.dart';
import 'app.dart';
import 'package:dio/dio.dart';

Future<void> testNetwork() async {
  try {
    final res = await Dio().get('https://jsonplaceholder.typicode.com/todos/1');
    debugPrint('Test success: ${res.statusCode} ${res.data}');
  } catch (e) {
    debugPrint('Test failed: $e');
  }
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());

}
