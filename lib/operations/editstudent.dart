import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:schoolregister/consts.dart';
import 'package:schoolregister/db/db_functions.dart/db_functions.dart';
import 'package:schoolregister/db/model/data_model.dart';

class EditStudent extends StatelessWidget {
  EditStudent({super.key, required this.data});

  final StudentModel data;

  final _updateNameController = TextEditingController();

  final _updateAgeController = TextEditingController();

  final _updateContactController = TextEditingController();

  final _updateEmailController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    _updateAgeController.text = data.age;
    _updateNameController.text = data.name;
    _updateContactController.text = data.contact;
    _updateEmailController.text = data.email;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 234, 234, 234),
      appBar: AppBar(
        backgroundColor: black,
        title: const Text(
          'EDIT DETAILS',
          style: TextStyle(color: Color.fromARGB(213, 255, 255, 255)),
        ),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
              child: Column(
            children: [
              const SizedBox(
                height: 50,
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
                      onTap: () {
                        Navigator.pop(context);
                      },
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
                height: 30,
              ),
              TextFormField(
                controller: _updateNameController,
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
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(
                      width: 2,
                      color: Color.fromARGB(255, 165, 89, 83),
                    ),
                  ),
                  hintText: 'Name',
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: _updateAgeController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Age is required';
                  } else if (!RegExp(r'^[0-9]{1,2}').hasMatch(value) ||
                      (value.length) > 2) {
                    return 'Enter valie age';
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
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: _updateEmailController,
                validator: (value) {
                  if (_updateEmailController.text.isEmpty ||
                      !RegExp(r'[A-Za-z\._\-[0-9]*[@][A-Za-z]*[\.][a-z]{2,4}')
                          .hasMatch(value!)) {
                    return 'Enter valied Email ID';
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
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: _updateContactController,
                validator: (value) {
                  if ((_updateContactController.text.isEmpty)) {
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
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: () {
                  final name = _updateNameController.text.trim();
                  final age = _updateAgeController.text.trim();
                  final email = _updateEmailController.text.trim();
                  final contact = _updateContactController.text.trim();

                  final student = StudentModel(
                    name: name,
                    age: age,
                    contact: contact,
                    email: email,
                    id: data.id,
                  );

                  Provider.of<DbFunctions>(context, listen: false)
                      .updateStudent(student);

                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text(
                            'Details Updated !',
                            style: TextStyle(
                                color: Color.fromARGB(255, 255, 255, 255),
                                fontWeight: FontWeight.bold),
                          ),
                          duration: Duration(seconds: 1),
                          backgroundColor: black),
                    );
                    Navigator.pop(context, true);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: black,
                  foregroundColor: const Color.fromARGB(255, 255, 255, 255),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
                child: const Text('Edit'),
              )
            ],
          )),
        ),
      ),
    );
  }
}
