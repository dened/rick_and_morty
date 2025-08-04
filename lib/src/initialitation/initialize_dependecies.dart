import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:l/l.dart';
import 'package:rick_and_morty/firebase_options.dart';
import 'package:rick_and_morty/src/database.dart';
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
    final database = Database();
    await database.refresh();
    dependencies.db = database;
  },
};
