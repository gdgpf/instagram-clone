import 'package:flutter/material.dart';
import 'package:instagram/app/page/login_page.dart';

var defaultPage;

void main() {
  defaultPage = LoginPage();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Instagram',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: defaultPage,
    );
  }
}
