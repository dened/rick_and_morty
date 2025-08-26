import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:l/l.dart';
import 'package:rick_and_morty/firebase_options.dart';
import 'package:rick_and_morty/src/data_source/api_repository.dart';
import 'package:rick_and_morty/src/data_source/favorites_repository.dart';
import 'package:rick_and_morty/src/data_source/remote_data_repository.dart';
import 'package:rick_and_morty/src/database.dart';
import 'package:rick_and_morty/src/home_screen/widget/home_screen.dart';
import 'package:rick_and_morty/src/initialization/dependencies.dart';

Future<Dependencies> initializeDependencies() async {
  final dependencies = Dependencies();
  final countSteps = _initializationSteps.length;
  var currentStep = 0;

  for (final step in _initializationSteps.entries) {
    try {
      currentStep++;
      l.v6('Initilazation | $currentStep/$countSteps | "${step.key}"');
      await step.value(dependencies);
    } on Object catch (error, stackTrace) {
      l.e('Initialization failed at step "${step.key}": $error', stackTrace);
      Error.throwWithStackTrace('Initialization failed at step "${step.key}": $error', stackTrace);
    }
  }

  return dependencies;
}

final Map<String, FutureOr<void> Function(Dependencies)> _initializationSteps = {
  'Firebase initialization': (_) async {
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  },
  'Database initialization': (dependencies) async {
    if (kIsWeb) return;

    final database = Database();
    await database.refresh();
    dependencies.db = database;
  },
  'Remote data repository initialization': (dependencies) async {
    dependencies.remoteDataRepository = RemoteDataRepositoryImpl(FirebaseFirestore.instance);
  },

  'Navigator initialization': (dependencies) async {
    dependencies.navigator = ValueNotifier([const MaterialPage<void>(child: HomeScreen())]);
  },

  'Api client initialization': (dependencies) async {
    dependencies.client = HttpClient();
  },

  'Api repository initialization': (dependencies) async {
    dependencies.apiRepository = ApiRepository(dependencies.client);
  },

  'Favorites repository initialization': (dependencies) async {
    dependencies.favoritesRepository = FavoritesRepositoryInMemory();
    dependencies.favoritesRepository.fetchFavorites().ignore();
  },
};
