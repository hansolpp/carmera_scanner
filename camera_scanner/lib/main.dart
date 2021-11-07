import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:camera/camera.dart';

import 'package:camera_scanner/app/app.dart';
import 'package:camera_scanner/core/core.dart';

List<CameraDescription> cameras = [];

void main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();

    await Firebase.initializeApp();

    Bloc.observer = AppBlocObserver();

    cameras = await availableCameras();
  } on Exception catch (e) {
    debugPrint('Error::Main -> Initialized | $e');
  }

  runApp(
    const DependencyInjection(isNotRequired: true, child: MlCameraApp()),
  );
}
