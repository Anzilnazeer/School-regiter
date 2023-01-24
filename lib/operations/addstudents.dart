import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:schoolregister/consts.dart';
import 'package:schoolregister/db/db_functions.dart/db_functions.dart';
import 'package:schoolregister/db/model/data_model.dart';
import 'package:schoolregister/homepage.dart';

class Addstudents extends StatefulWidget {
  const Addstudents({super.key});

  @override
  State<Addstudents> createState() => _AddstudentsState();
}

class _AddstudentsState extends State<Addstudents> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();

  final _ageController = TextEditingController();

  final _contactController = TextEditingController();

  final _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: black,
        title: const Text(
          'ADD STUDENT',
          style: TextStyle(
            color: Color.fromARGB(255, 255, 255, 255),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  Stack(
                    children: [
                      const CircleAvatar(
                        backgroundImage: AssetImage(
                          'lib/imgs/av athar.jpg',
                        ),
                        radius: 80,
                      ),
                      Positioned(
                        bottom: 10,
                        right: 10,
                        child: InkWell(
                          onTap: () {},
                          child: const Icon(
                            Icons.camera_alt,
                            color: Colors.black,
                            size: 40,
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: _nameController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Name is required';
                      } else if (value.contains('@') || value.contains('.')) {
                        return 'Enter valied Name';
                      } else {
                        return null;
                      }
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30)),
                      hintText: 'Name',
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _ageController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Age is required';
                      } else if (!RegExp(r'^[0-9]{1,2}').hasMatch(value) ||
                          (value.length) > 2) {
                        return 'Enter valied age';
                      } else {
                        return null;
                      }
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30)),
                      hintText: 'Age',
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _emailController,
                    validator: (value) {
                      if (_emailController.text.isEmpty ||
                          !RegExp(r'[A-Za-z\._\-[0-9]*[@][A-Za-z]*[\.][a-z]{2,4}')
                              .hasMatch(value!)) {
                        return 'Enter valid Email ID';
                      } else {
                        return null;
                      }
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30)),
                      hintText: 'Email',
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    controller: _contactController,
                    validator: (value) {
                      if ((_contactController.text.isEmpty)) {
                        return 'Phone Number is required';
                      } else {
                        return null;
                      }
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30)),
                      hintText: 'Contact',
                    ),
                  ),
                  const SizedBox(height: 20),
                  Consumer<DbFunctions>(
                    builder: (context, value, child) {
                      return ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'Student Added',
                                    style: TextStyle(
                                        color:
                                            Color.fromARGB(255, 255, 255, 255),
                                        fontWeight: FontWeight.bold),
                                  ),
                                  duration: Duration(seconds: 1),
                                  backgroundColor: black,
                                ),
                              );

                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const HomePage(),
                                ),
                              );
                              onAddButton();
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromARGB(255, 39, 39, 39),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text(
                            'Add',
                          ));
                    },
                  )
                ],
              )),
        ),
      ),
    );
  }

  Future<void> onAddButton() async {
    final name = _nameController.text.trim();
    final age = _ageController.text.trim();
    final email = _emailController.text.trim();
    final contact = _contactController.text.trim();
    if (name.isEmpty || age.isEmpty || email.isEmpty || contact.isEmpty) {
      return;
    }
    final student =
        StudentModel(name: name, age: age, email: email, contact: contact);

    Provider.of<DbFunctions>(context, listen: false).addStudent(student);
  }
}
