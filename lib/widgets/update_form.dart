import 'dart:io';

import 'package:adopt_app/models/pet.dart';
import 'package:adopt_app/providers/pets_provider.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

var _image;
final _picker = ImagePicker();

class UpdateForm extends StatefulWidget {
  Pet pet;

  UpdateForm({required this.pet});

  @override
  UpdateFormState createState() {
    return UpdateFormState();
  }
}

class UpdateFormState extends State<UpdateForm> {
  final _formkey = GlobalKey<FormState>();
  String name = "";
  String gender = "";
  int age = 0;
  @override
  Widget build(BuildContext context) {
    Pet pet = widget.pet;
    return Form(
        key: _formkey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(
                hintText: 'name',
              ),
              initialValue: pet.name,
              validator: (value) {
                if (value!.isEmpty) {
                  return "Name cannot be empty";
                } else {
                  return null;
                }
              },
              onSaved: (value) {
                name = value!;
              },
            ),
            TextFormField(
                decoration: InputDecoration(
                  hintText: 'age',
                ),
                initialValue: pet.name,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Age cannot be empty";
                  }
                  if (int.tryParse(value) == null) {
                    return "please enter your number";
                  }
                  return null;
                },
                onSaved: (value) {
                  age = int.parse(value!);
                }),
            TextFormField(
              decoration: InputDecoration(
                hintText: 'Gender',
              ),
              initialValue: pet.name,
              validator: (value) {
                if (value!.isEmpty) {
                  return "Gender cannot be empty";
                } else if (value != 'Male' && value != 'Female') {
                  return "Gender must be female or male";
                }
                return null;
              },
              onSaved: (value) {
                gender = value!;
              },
            ),
            Row(
              children: [
                GestureDetector(
                  onTap: () async {
                    var im =
                        await _picker.pickImage(source: ImageSource.gallery);
                    if (im == null) return;

                    setState(() {
                      _image = File(_image!.path);
                    });
                  },
                )
              ],
            ),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  if (_formkey.currentState!.validate()) {
                    _formkey.currentState!.save();
                    Provider.of<PetsProvider>(context, listen: false).updatePet(
                        Pet(
                            name: name,
                            image: _image.path,
                            age: age,
                            gender: gender));
                  }
                },
                child: const Text("Submit"),
              ),
            )
          ],
        ));
  }
}
