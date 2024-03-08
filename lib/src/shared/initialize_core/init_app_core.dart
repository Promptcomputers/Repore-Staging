import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:repore/data/util/app_config/environment.dart';
import 'package:repore/firebase_options.dart';
import 'package:repore/src/shared/preference_manager.dart';

Future<void> initializeCore({required Environment environment}) async {
  AppConfig.environment = environment;

  await PreferenceManager.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  log("$environment");
}
