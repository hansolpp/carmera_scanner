import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:camera_scanner/app/app.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/bloc/bloc_observer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  Bloc.observer = AppBlocObserver();

  runApp(const MlCameraApp());
}
