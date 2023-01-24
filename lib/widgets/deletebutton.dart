import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../db/db_functions.dart/db_functions.dart';
import '../db/model/data_model.dart';

class DeleteButton extends StatelessWidget {
  const DeleteButton({
    Key? key,
    required this.data,
    required this.index,
  }) : super(key: key);

  final StudentModel data;
  final int index;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              backgroundColor: Colors.white,
              title: const Text(
                'Do you want to delete ?',
                style: TextStyle(color: Color.fromARGB(255, 5, 5, 5)),
              ),
              content: Text(
                'You are going to delete the student ${data.name}',
                style: const TextStyle(color: Color.fromARGB(255, 126, 19, 19)),
              ),
              actions: [
                Consumer<DbFunctions>(
                  builder: (context, value, child) {
                    return TextButton(
                      onPressed: () {
                        value.deleteStudent(index);
                        Navigator.pop(context);
                      },
                      style: TextButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 143, 0, 0)),
                      child: const Text(
                        'Delete',
                        style: TextStyle(color: Colors.white),
                      ),
                    );
                  },
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Cancel',
                    style: TextStyle(
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                  ),
                )
              ],
            );
          },
        );
      },
      icon: const Icon(Icons.delete),
      color: const Color.fromARGB(255, 192, 13, 0),
    );
  }
}
