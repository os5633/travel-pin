import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:travelpin/app/app.dart';
import 'package:travelpin/common/common.dart';
import 'package:travelpin/repository/repository.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = AppBlocObserver();
  await Firebase.initializeApp();
  await DeviceInfoHelper.init();
  final authenticationRepository = AuthenticationRepository();

  return runApp(App(authenticationRepository: authenticationRepository));
}
