import 'package:flutter/widgets.dart';
import 'package:camera/camera.dart';
import 'package:google_ml_kit/google_ml_kit.dart';

import 'package:camera_scanner/core/camera/vision_detector/vision_detector_manager/vision_detector_manager.dart';
import 'package:camera_scanner/app/pages/splash/home/camera/camera.dart';
import 'package:camera_scanner/core/camera/camera_manager/camera_manager.dart';

class CameraImageDetectorView extends StatefulWidget {
  const CameraImageDetectorView({Key? key}) : super(key: key);

  @override
  State<CameraImageDetectorView> createState() =>
      _CameraImageDetectorViewState();
}

class _CameraImageDetectorViewState extends State<CameraImageDetectorView> {
  final VisionDetectorManager visionDetectorManager = VisionDetectorManager();
  final CameraController _cameraController = CameraController(
    CameraManager.availableCamera[backCamera],
    ResolutionPreset.high,
  );
  late RecognisedText recognisedText;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        CameraPage(
          cameraController: _cameraController,
          onStream: (CameraImage image) async {
            recognisedText = await visionDetectorManager.processImage(image);
          },
        ),
        Container(
          decoration: ShapeDecoration(
            shape: ScannerOverlayShape(
              cutOutWidth: 300,
              cutOutHeight: 300,
            ),
          ),
        ),
      ],
    );
  }
}
