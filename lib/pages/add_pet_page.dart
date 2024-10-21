import 'package:adopt_app/widgets/add_form.dart';
import 'package:flutter/material.dart';

class AddpetPage extends StatelessWidget {
  const AddpetPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Add pet page"),
        ),
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: AddPetForm(),
        ));
  }
}
