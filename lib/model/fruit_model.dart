import 'package:hive/hive.dart';
part 'fruit_model.g.dart';

@HiveType(typeId:0)

class FruitModel extends HiveObject{
  @HiveField(0)
  String? name;

   @HiveField(1)
  String? type;

   @HiveField(2)
  String? desc;

   @HiveField(3)
  String? id;


  FruitModel({required this.name,required this.type,required this.desc,required this.id});
}