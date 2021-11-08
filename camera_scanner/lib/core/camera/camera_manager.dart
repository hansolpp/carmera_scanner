import 'package:flutter/widgets.dart';
import 'package:camera/camera.dart';

const backCamera = 0;
const frontCamera = 1;

class CameraManager {
  CameraManager._();

  static List<CameraDescription> cameras = [];

  static get availableCamera => cameras;

  static Future<List<CameraDescription>> getAvailableCamera() async {
    try {
      return cameras = await availableCameras();
    } on CameraException catch (e) {
      debugPrint('CameraError: ${e.description}');
    }
    return [];
  }
}
