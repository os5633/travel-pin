import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:travelpin/app/app.dart';
import 'package:travelpin/firebase_options.dart';
import 'package:travelpin/repository/repository.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  Bloc.observer = AppBlocObserver();
  final authenticationRepository = AuthenticationRepository();
  FirebaseAuth.instance.signInAnonymously();

  return runApp(App(authenticationRepository: authenticationRepository));
}
