import 'package:flutter/material.dart';
import 'package:flutter_news_api/screens/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter News',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          appBarTheme: const AppBarTheme(
        foregroundColor: Colors.black,
        color: Colors.white,
      )),
      home: Home(),
    );
  }
}
