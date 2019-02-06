import 'package:flutter/material.dart';
import 'package:volume_control/main_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  MyAppState createState() {
    return new MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          primarySwatch: Colors.teal,
          textTheme: TextTheme(subhead: TextStyle(color: Colors.teal))),
      home: MainPage(),
    );
  }
}
