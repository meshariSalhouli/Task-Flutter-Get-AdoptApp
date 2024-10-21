import 'dart:io';

import 'package:adopt_app/models/pet.dart';
import 'package:adopt_app/providers/pets_provider.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

var _image;
final _picker = ImagePicker();

class AddPetForm extends StatefulWidget {
  @override
  AddPetFormState createState() {
    return AddPetFormState();
  }
}

class AddPetFormState extends State<AddPetForm> {
  final _formkey = GlobalKey<FormState>();
  String name = "";
  String gender = "";
  int age = 0;
  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formkey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(
                hintText: 'name',
              ),
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
                onPressed: () async {
                  if (_formkey.currentState!.validate()) {
                    _formkey.currentState!.save();
                    var success = await context.read<PetsProvider>().createPet(
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
