import 'package:adopt_app/models/pet.dart';
import 'package:adopt_app/widgets/add_form.dart';
import 'package:adopt_app/widgets/update_form.dart';
import 'package:flutter/material.dart';

class UpdatePetPage extends StatelessWidget {
  final Pet pet;

  const UpdatePetPage({required this.pet});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Add pet page"),
        ),
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: UpdateForm(pet: pet),
        ));
  }
}
