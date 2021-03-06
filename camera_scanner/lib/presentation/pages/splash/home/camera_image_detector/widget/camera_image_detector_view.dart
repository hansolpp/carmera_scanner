import 'package:flutter/widgets.dart';
import 'package:camera/camera.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'dart:developer' as developer;

import 'package:camera_scanner/core/camera/vision_detector/vision_detector_manager/vision_detector_manager.dart';
import 'package:camera_scanner/core/camera/camera_manager/camera_manager.dart';
import 'package:camera_scanner/presentation/pages/splash/home/camera/camera.dart';

class CameraImageDetectorView extends StatefulWidget {
  const CameraImageDetectorView({Key? key}) : super(key: key);

  @override
  State<CameraImageDetectorView> createState() =>
      _CameraImageDetectorViewState();
}

class _CameraImageDetectorViewState extends State<CameraImageDetectorView> {
  final VisionDetectorManager _visionDetectorManager = VisionDetectorManager();
  final CameraController _cameraController = CameraController(
    CameraManager.availableCamera[backCamera],
    ResolutionPreset.high,
  );
  late RecognisedText recognisedText;
  late final CameraScannerOverlayShape _overlayShape =
      CameraScannerOverlayShape(targetRect: (Rect targetRect) {
    developer.log('overlayShape.left:: ${targetRect.left}');
    developer.log('overlayShape.top:: ${targetRect.top}');
    developer.log('overlayShape.right:: ${targetRect.right}');
    developer.log('overlayShape.bottom:: ${targetRect.bottom}');
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        CameraPage(
          cameraController: _cameraController,
          decoration: ShapeDecoration(shape: _overlayShape),
          onStream: (CameraImage image) async {
            // TODO : isolate 사용하여 구현해보고 성능 차이 측정하기
            recognisedText = await _visionDetectorManager.processImage(image);
          },
        ),
      ],
    );
  }
}
