import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'dart:developer' as developer;

import 'package:camera_scanner/core/camera/camera.dart';

class CameraView extends StatefulWidget {
  const CameraView({
    this.cameraController,
    this.decoration,
    this.onStream,
    Key? key,
  }) : super(key: key);

  final CameraController? cameraController;
  final Decoration? decoration;
  final ValueChanged<CameraImage>? onStream;

  @override
  State<StatefulWidget> createState() => _CameraViewState();
}

class _CameraViewState extends State<CameraView> {
  late final CameraController _cameraController;
  late Future<bool> _isCameraInitialized;
  bool _isDetecting = false;

  @override
  void initState() {
    super.initState();
    _isCameraInitialized = _initializeCamera(
      controller: widget.cameraController,
      position: backCamera,
    );
  }

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: _isCameraInitialized,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return CameraPreview(
            _cameraController,
            child: Container(decoration: widget.decoration),
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Future<bool> _initializeCamera({
    CameraController? controller,
    int? position,
  }) async {
    final CameraController cameraController = CameraController(
      CameraManager.availableCamera[position],
      /// Know issue:: some device have frame drop problem(old device),
      /// when ResolutionPreset is more than medium resolution
      ResolutionPreset.medium,
    );

    _cameraController = controller ?? cameraController;

    await _cameraController.initialize();

    if (!mounted) return false;
    _cameraController.startImageStream((CameraImage image) async {
      if (_isDetecting) return;

      setState(() {
        _isDetecting = true;
      });
      widget.onStream?.call(image);
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
