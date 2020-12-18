import 'package:flutter/material.dart';
import 'package:instagram/app/page/feed_page.dart';
import 'package:instagram/app/page/login_page.dart';
import 'package:instagram/device/repository/profile_local_reposiitory.dart';
import 'package:instagram/domain/model/profile.dart';

var defaultPage;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final local = ProfileLocalRepository();

  Profile profile = await local.select();

  print(profile);

  if (profile != null) {
    defaultPage = FeedPage();
  } else {
    defaultPage = LoginPage();
  }

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
