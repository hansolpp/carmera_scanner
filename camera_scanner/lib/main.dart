import 'package:camera_scanner/injection_container.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:camera_scanner/presentation/app.dart';
import 'package:camera_scanner/core/core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  Bloc.observer = AppBlocObserver();

  await CameraManager.getAvailableCamera();

  runApp(
    const InjectionContainer(
      isNotRequired: true,
      child: MlCameraApp(),
    ),
  );
}
