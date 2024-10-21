import 'package:adopt_app/models/pet.dart';
import 'package:adopt_app/pages/update_pet_page.dart';
import "package:dio/dio.dart";

class DioClient {
  final Dio _dio = Dio();
  final _baseUrl =
      'https://https://coded-pets-api-crud.eapi.joincoded.com/pets';

  Future<List<Pet>> getPets() async {
    List<Pet> pets = [];
    try {
      Response response =
          await _dio.get("https://coded-pets-api-crud.eapi.joincoded.com/pets");
      pets = (response.data as List).map((pet) => Pet.fromJson(pet)).toList();
    } on DioException catch (error) {
      print(error);
    }
    return pets;
  }

  Future<Pet> createPet({required Pet toCreate}) async {
    try {
      FormData data = FormData.fromMap({
        "name": toCreate.name,
        "age": toCreate.age,
        "gender": toCreate.gender,
        "image": await MultipartFile.fromFile(
          toCreate.image,
        ),
      });
      Response response = await _dio.post('$_baseUrl/pets', data: data);
      return Pet.fromJson(response.data);
    } on DioException catch (error) {
      print(error);
    }
    throw "Unsuccessful request";
  }

  Future<Pet> updatePet({required Pet pet}) async {
    late Pet retrievedPet;
    try {
      FormData data = FormData.fromMap({
        "name": pet.name,
        "age": pet.age,
        "gender": pet.gender,
        "image": await MultipartFile.fromFile(
          pet.image,
        ),
      });
      Response response =
          await _dio.put(_baseUrl + '/pets/${pet.id}', data: data);
      retrievedPet = Pet.fromJson(response.data);
    } on DioException catch (error) {
      print("error");
    }
    return retrievedPet;
  }
}
