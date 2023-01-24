import 'package:hive_flutter/adapters.dart';
part 'data_model.g.dart';

@HiveType(typeId: 1)
class StudentModel {
  @HiveField(0)
  int? id;
  @HiveField(1)
  final name;
  @HiveField(2)
  final age;
  @HiveField(3)
  final email;
  @HiveField(4)
  final contact;
  @HiveField(5)
  StudentModel({
    required this.name,
    required this.age,
    required this.email,
    required this.contact,
    this.id,
  });
}
