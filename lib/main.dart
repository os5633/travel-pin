import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:travelpin/app/app.dart';
import 'package:travelpin/repository/repository.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Bloc.observer = AppBlocObserver();
  final authenticationRepository = AuthenticationRepository();
  FirebaseAuth.instance.signInAnonymously();

  return runApp(App(authenticationRepository: authenticationRepository));
}
