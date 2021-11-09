import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:camera/camera.dart';
import 'dart:developer' as developer;

import 'package:camera_scanner/core/camera/camera.dart';

class CameraView extends StatefulWidget {
  const CameraView({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _CameraViewState();
}

class _CameraViewState extends State<CameraView> {
  late final CameraController _cameraController;
  late Future<bool> _isInitialized;
  late RecognisedText recognisedText;
  bool _isDetecting = false;
  final VisionDetectorManager visionDetectorManager = VisionDetectorManager();

  @override
  void initState() {
    super.initState();
    _isInitialized = _initializeCamera();
  }

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: _isInitialized,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return CameraPreview(_cameraController);
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget buildCameraPreview() {
    if (!_cameraController.value.isInitialized) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return CameraPreview(_cameraController);
  }

  Future<bool> _initializeCamera() async {
    final CameraController cameraController = CameraController(
      CameraManager.availableCamera[backCamera],
      ResolutionPreset.high,
    );
    _cameraController = cameraController;

    await _cameraController.initialize();

    if (!mounted) return false;
    _cameraController.startImageStream((CameraImage image) async {
      if (_isDetecting) return;

      setState(() {
        _isDetecting = true;
      });
      recognisedText = await visionDetectorManager.processImage(image);
      developer.log('$recognisedText');
      _isDetecting = false;
    });
    return true;
  }

  Future<String?> _takePicture() async {
    if (!_cameraController.value.isInitialized) {
      developer.log("Controller is not initialized");
      return null;
    }

    String? imagePath;

    if (_cameraController.value.isTakingPicture) {
      developer.log("Processing is in progress...");
      return null;
    }

    try {
      // Turning off the camera flash
      _cameraController.setFlashMode(FlashMode.off);
      // Returns the image in cross-platform file abstraction
      final XFile file = await _cameraController.takePicture();
      // Retrieving the path
      imagePath = file.path;
    } on CameraException catch (e) {
      developer.log("Camera Exception: $e");
      return null;
    }

    return imagePath;
  }
}
