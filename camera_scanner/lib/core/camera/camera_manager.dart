import 'package:camera/camera.dart';
import 'package:flutter/widgets.dart';

const backCamera = 0;
const frontCamera = 1;

class CameraManager {
  CameraManager._();

  static List<CameraDescription> cameras = [];

  static get availableCamera => cameras;

  static getAvailableCamera() async {
    try {
      cameras = await availableCameras();
    } on CameraException catch (e) {
      debugPrint('CameraError: ${e.description}');
    }
  }
}
