import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:schoolregister/consts.dart';
import 'package:schoolregister/db/model/data_model.dart';
import 'package:schoolregister/operations/editstudent.dart';
import 'package:schoolregister/homepage.dart';

import '../db/db_functions.dart/db_functions.dart';

class MySearch extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            if (query.isEmpty) {
              close(context, null);
            } else {
              query = '';
            }
          },
          icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    return Center(
      child: Text(query),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final  listItems = query.isEmpty
        ? Provider.of<DbFunctions>(context).studentlist
        : Provider.of<DbFunctions>(context)
            .studentlist
            .where((element) => element.name
                .toLowerCase()
                .startsWith(query.toLowerCase().toString()))
            .toList();

    return listItems.isEmpty
        ? const Center(child: Text("Student not exist!"))
        : ListView.builder(
            itemCount: listItems.length,
            itemBuilder: (context, index) {
              return Padding(
                  padding: const EdgeInsets.only(left: 15.00, right: 15.00),
                  child: Column(
                    children: [
                      ListTile(
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(
                              color: Color.fromARGB(255, 44, 44, 44), width: 1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        tileColor: const Color.fromARGB(255, 255, 255, 255),
                        leading: const CircleAvatar(
                          backgroundImage: AssetImage(
                            'lib/imgs/av athar.jpg',
                          ),
                          radius: 30,
                        ),
                        title: Text(
                          listItems[index].name,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, color: black),
                        ),
                        subtitle: Text(listItems[index].email,
                            style: const TextStyle(
                                fontStyle: FontStyle.italic, color: black)),
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (ctx) =>
                                  EditStudent(data: listItems[index])));
                        },
                      ),
                      const Divider(
                        thickness: 3,
                        color: Colors.grey,
                      ),
                    ],
                  ));
            });
  }
}
