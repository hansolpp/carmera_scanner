import 'package:camera_scanner/core/camera/camera.dart';
import 'package:flutter/widgets.dart';
import 'package:camera/camera.dart';

class CameraView extends StatefulWidget {
  const CameraView({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => CameraViewState();
}

class CameraViewState extends State<CameraView> {
  late final CameraController _controller;

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  void _initializeCamera() async {
    final CameraController cameraController = CameraController(
      CameraManager.availableCamera.first,
      ResolutionPreset.high,
    );
    _controller = cameraController;

    _controller.initialize().then((_) {
      if (!mounted) return;
      setState(() {});
    });
  }
}
