import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';

import '../model/data_model.dart';

// ValueNotifier<List<StudentModel>> studentlistNotifier = ValueNotifier([]);

class DbFunctions extends ChangeNotifier {
  List<StudentModel> studentlist = [];
  Future<void> addStudent(StudentModel value) async {
    final studentDB = await Hive.openBox<StudentModel>('student_db');
    final id = await studentDB.add(value);
    value.id = id;

    final data = StudentModel(
        id: id,
        name: value.name,
        age: value.age,
        contact: value.contact,
        email: value.email);
    await studentDB.put(id, data);
    studentlist.add(value);

    // studentlistNotifier.notifyListeners();
    notifyListeners();
  }

  Future<void> getAllStudents() async {
    final studentDB = await Hive.openBox<StudentModel>('student_db');
    studentlist.clear();
    studentlist.addAll(studentDB.values);
    // studentlistNotifier.value.clear();
    // studentlistNotifier.value.addAll(studentDB.values);
    // studentlistNotifier.notifyListeners();
    notifyListeners();
  }

  Future<void> deleteStudent(int id) async {
    final studentDB = await Hive.openBox<StudentModel>('student_db');
    await studentDB.deleteAt(id);
    getAllStudents();
  }

  Future<void> updateStudent(StudentModel data) async {
    final studentDB = await Hive.openBox<StudentModel>('student_db');

    await studentDB.put(data.id, data);
    getAllStudents();
  }
}
