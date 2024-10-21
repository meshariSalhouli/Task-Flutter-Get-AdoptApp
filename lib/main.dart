import 'package:adopt_app/models/pet.dart';
import 'package:adopt_app/pages/add_pet_page.dart';
import 'package:adopt_app/pages/home_page.dart';
import 'package:adopt_app/providers/pets_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:adopt_app/pages/update_pet_page.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => PetsProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: _router,
    );
  }

  final _router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const HomePage(),
      ),
      GoRoute(
        path: '/add_pet_page',
        builder: (context, state) => AddpetPage(),
      ),
      GoRoute(
        path: '/update/:petId',
        builder: (context, state) {
          final pet = Provider.of<PetsProvider>(context).pets.firstWhere(
              (pet) => pet.id.toString() == (state.pathParameters['petsId']!));
          return UpdatePetPage(pet: pet);
        },
      ),
    ],
  );
}
