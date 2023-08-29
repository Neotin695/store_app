import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/services/common.dart';
import 'firebase_options.dart';
import 'store_app/app/app.dart';
import 'store_app/auth/repository/authentication_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = AppBlocObserver();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Common.prefs = await SharedPreferences.getInstance();

  final authenticationRepository = AuthenticationRepository();

  await authenticationRepository.user.first;
  runApp(App(authenticationRepository: authenticationRepository));
}
