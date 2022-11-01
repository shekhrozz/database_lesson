import 'dart:developer';

import 'package:database_lesson/services/no_sql_src.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:database_lesson/model/fruit_model.dart';
import 'package:uuid/uuid.dart';

class FruitsView extends StatefulWidget {
  const FruitsView({Key? key}) : super(key: key);

  @override
  State<FruitsView> createState() => _FruitsViewState();
}

class _FruitsViewState extends State<FruitsView> {
  final dbeService=HiveDbSrc();
  final name=TextEditingController();
  final type=TextEditingController();
  final desc=TextEditingController();
  @override
  void initState() {
    addData();
    super.initState();
  }

 void addData()async {
  try {
    final isSaved=await dbeService.saveDataToHiveBoxAsJson(fruits: [
          FruitModel(
            name: 'Apple', type: 'Hol meva', desc: 'Zor meva', id: '1234'),
        FruitModel(
            name: 'Melon', type: 'Hol meva', desc: 'Zor meva', id: '123one'),
        FruitModel(
            name: 'Banana', type: 'Hol meva', desc: 'Zor meva', id: '123490'),
        FruitModel(
            name: 'Lemon', type: 'Hol meva', desc: 'Zor meva', id: '123409'),
        FruitModel(
            name: 'Orange', type: 'Hol meva', desc: 'Zor meva', id: '12347'),
    ], key:'fruits');
    debugPrint(isSaved.toString());
  } catch (e) {
    log(e.toString());
  }
 }


//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

  @override
  Widget build(BuildContext context) {
   return Scaffold(
       body: Builder(builder:(context) {
         return FutureBuilder<List<FruitModel>>(
          future: dbeService.getFruits(key: 'fruits'),
          builder:(context, snapshot) {
           if(snapshot.connectionState==ConnectionState.waiting){
            return const Center(
              child: CupertinoActivityIndicator(),
            );
           }
            if (snapshot.hasData) {
              return const Center(
                child: Text('you have not data'),
              );
            }
            if(snapshot.hasError){
              return const Center(
                child: Text('you have an error'),
              );
            }
            return ListView.separated(
              itemBuilder:(context, index) {
                final FruitModel fruit =snapshot.data![index];

                return  Card(child: ListTile(
                  title: Text(fruit.name!),
                  subtitle: Text(fruit.type!),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(onPressed: (){
                        showCreateFruit(isAdd: false,uid: fruit.id);
                      }, icon:Icon(Icons.edit)),

                      IconButton(onPressed: ()async{
                        final bool isDeleted=await dbeService.deleteDataUsingId(
                          id:fruit.id, key:'fruits');
                          if(isDeleted){
                            debugPrint('o\'chirildi');
                          }
                          setState(() {
                            
                          }
                          );
                      }, icon: const Icon(Icons.delete))
                    ],
                  ),
                ),
                );
              },
              separatorBuilder:(context, index) => const Divider(),
               itemCount: snapshot.data!.length);
         }
         );
       },
       
       ),
   ); 
  }

  // show CupertinoDialog

  void showCreateFruit({bool? isAdd=true,String? uid }){
    showCupertinoDialog(
      barrierDismissible: true,
      context: context, builder:(context) => 
    CupertinoAlertDialog(
      title: const Text('Create Fruit'),

      content: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CupertinoTextField(
              controller: name,
              placeholder: "name",
            ),
              CupertinoTextField(
              controller: type,
              placeholder: "type",
            ),
              CupertinoTextField(
              controller: desc,
              placeholder: "desc",
            )
          ],
        ),
      ),
       actions: [CupertinoDialogAction(
        onPressed:() => isAdd==true? onCreateFruits():onUpdateFruit(uid: uid),
        child:Text(isAdd! ?'add':"update"))],
    ),
    
    );
  }
  //  onUpdateFruit
 void onUpdateFruit({required String? uid}) async {
    try {
      if (name.text.isEmpty || type.text.isEmpty || desc.text.isEmpty) return;

      FruitModel? fruit = FruitModel(
          name: name.text, type: type.text, desc: desc.text, id: uid);
      final isUpdated =
          await dbeService.updateFriutToData(key: 'fruits', fruit: fruit);
      name.clear();
      type.clear();
      desc.clear();
      if (isUpdated) {
        setState(() {
          Navigator.of(context).pop();
          debugPrint('YANGILNDI');
        });
      }
    } catch (e, s) {
      debugPrint(e.toString());
      debugPrint(s.toString());
    }
  }

    // onCreateFruits


    void onCreateFruits() async {
    try {
      if (name.text.isEmpty || type.text.isEmpty || desc.text.isEmpty) return;

      FruitModel? fruit = FruitModel(
          name: name.text,
          type: type.text,
          desc: desc.text,
          id: const Uuid().v1());
      final isCreated =
          await dbeService.addFruitToData(key: 'fruits', fruit: fruit);
      name.clear();
      type.clear();
      desc.clear();
      if (isCreated) {
        setState(() {
          Navigator.of(context).pop();
          debugPrint('USER ADDED TO TABLE');
        });
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
