import 'package:adopt_app/models/pet.dart';
import 'package:adopt_app/pages/update_pet_page.dart';
import 'package:adopt_app/services/pets.dart';
import 'package:flutter/material.dart';

class PetsProvider extends ChangeNotifier {
  List<Pet> pets = [
    Pet(
        name: "Lucifurr",
        image: "https://i.ibb.co/P6VJ4pZ/smile-cat-1.png",
        age: 2,
        gender: "male")
  ];
//Assign the future property to the getPets function we created.
  Future<void> getPets() async {
    pets = await DioClient().getPets();
    notifyListeners();
  }

  // should accept pet parameter
  Future<bool> createPet(Pet pet) async {
    // create the pet parameter by passing it to service
    try {
      var addpet = await DioClient().createPet(toCreate: pet);
      // get added pet and insert in ito list
      pets.insert(0, addpet);
      notifyListeners();
      return true;
    } catch (e) {
      return false;
    }
  }

  void updatePet(Pet pet) async {
    Pet newpet = await DioClient().updatePet(pet: pet);
    int index = pets.indexWhere((pet) => pet.id == newpet.id);
    pets[index] = newpet;
    notifyListeners();
  }
}
