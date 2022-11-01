import 'package:database_lesson/fortab/tab.dart';
import 'package:database_lesson/page/fruit/fruit_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {

  List<Widget?>pages=[ FruitsView(),fdfdf()];
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Database Example'),
        actions: [
          IconButton(onPressed:() {
                 }, icon: Icon(Icons.logout)
          ),
        ],
      ),
      body: CupertinoTabScaffold(tabBar:CupertinoTabBar(items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.data_object_sharp,),
           label: "NoSql"),
            BottomNavigationBarItem(
          icon: Icon(Icons.data_object_sharp,),
           label: "NoSql")
      ]
      ),
      tabBuilder:(context, index) => pages[index]!, ),
    );
  }
}