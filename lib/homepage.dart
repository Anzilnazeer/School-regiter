import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:schoolregister/consts.dart';
import 'package:schoolregister/operations/addstudents.dart';
import 'package:schoolregister/db/db_functions.dart/db_functions.dart';
import 'package:schoolregister/operations/editstudent.dart';
import 'package:schoolregister/widgets/searchlist.dart';

import 'widgets/deletebutton.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    Provider.of<DbFunctions>(context).getAllStudents;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 234, 234, 234),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        toolbarHeight: 100,
        actions: [
          IconButton(
            onPressed: () {
              showSearch(context: context, delegate: MySearch());
            },
            icon: const Icon(
              Icons.search,
              color: black,
            ),
          ),
        ],
        title: const Text(
          'LOURDES MOUNT SCHOOL',
          style: TextStyle(color: black),
        ),
        leading: const Padding(
          padding: EdgeInsets.all(8.0),
          child: CircleAvatar(
            radius: 30,
            foregroundImage: NetworkImage(
              'https://lh3.googleusercontent.com/vqGFFOD0UqyM7ocLlLPLfea_4ijUXjurDNcz29Aex0zOPkjfy97-Bep5Xh7QSLTpJRkrUMfOcCfc95snqOKiecm7OA',
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(
              width: double.infinity,
              height: 50.0,
              child: DecoratedBox(
                decoration: BoxDecoration(color: black),
                child: Center(
                    child: Text(
                  'STUDENTS LIST',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                )),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: Consumer<DbFunctions>(
                builder: (context, value, child) => ListView.separated(
                  itemBuilder: (context, index) {
                    // final data =
                    //     Provider.of<DbFunctions>(context).studentlist;
                    return Padding(
                      padding: const EdgeInsets.only(
                        left: 10,
                        right: 10,
                      ),
                      child: ListTile(
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(
                                color: Color.fromARGB(255, 53, 53, 53),
                                width: 1),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          tileColor: const Color.fromARGB(255, 255, 255, 255),
                          leading: const CircleAvatar(
                            backgroundImage: AssetImage(
                              'lib/imgs/av athar.jpg',
                            ),
                            radius: 30,
                          ),
                          trailing: DeleteButton(
                            data: value.studentlist[index],
                            index: index,
                          ),
                          title: Text(
                            value.studentlist[index].name,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, color: black),
                          ),
                          subtitle: Text(value.studentlist[index].email,
                              style: const TextStyle(
                                  fontStyle: FontStyle.italic, color: black)),
                          onTap: () {
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (ctx) {
                              return EditStudent(
                                  data: value.studentlist[index]);
                            }));
                          }),
                    );
                  },
                  separatorBuilder: ((context, index) {
                    return const Divider(
                      color: Colors.white,
                      thickness: 1,
                    );
                  }),
                  itemCount: value.studentlist.length,
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
          backgroundColor: black,
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: ((context) => const Addstudents()),
            ));
          },
          label: const Text('Add Student')),
    );
  }
}
