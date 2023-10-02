import 'package:flutter/material.dart';
import 'package:todohive/homepage.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'authentication_page.dart';

void main() async {
  await Hive.initFlutter();
  var box = await Hive.openBox('mybox');
  runApp(MyApp(box: box));
}

class MyApp extends StatelessWidget {
  final Box box;

  const MyApp({Key? key, required this.box}) : super(key: key);

  @override
  Widget build(BuildContext context) {
   
    String? loggedInUser = box.get('loggedInUser');
    Widget initialPage = loggedInUser != null ? Homepage() : AuthenticationPage();

    return MaterialApp(
      home: initialPage,
    );
  }
}
