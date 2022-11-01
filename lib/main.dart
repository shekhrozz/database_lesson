import 'package:database_lesson/page/home/home_view.dart';
import 'package:flutter/material.dart';
import 'package:database_lesson/services/no_sql_src.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  HiveDbSrc();
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(   
        primarySwatch: Colors.blue,
      ),
     home: HomeView(),
    );
  }
}
