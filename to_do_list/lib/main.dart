import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:to_do_list/pages/home.dart';

void main() async {

  //init db
  await Hive.initFlutter();

  //open box
  var box = await Hive.openBox('mybox');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
      theme: ThemeData(primarySwatch: Colors.blue),
    );
  }
}