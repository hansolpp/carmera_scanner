import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:camera/camera.dart';

import 'package:camera_scanner/app/app.dart';
import 'package:camera_scanner/core/core.dart';

void main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();

    await Firebase.initializeApp();

    Bloc.observer = AppBlocObserver();

    CameraManager.getAvailableCamera();
  } on Exception catch (e) {
    debugPrint('Error::Main -> Initialized | $e');
  }

  runApp(
    const DependencyInjection(isNotRequired: true, child: MlCameraApp()),
  );
}
