import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import 'package:camera_scanner/core/route/route_name.dart';
import 'package:camera_scanner/app/pages/splash/home/camera/camera.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({
    this.cameraController,
    this.decoration,
    this.onStream,
    Key? key,
  }) : super(key: key);

  final CameraController? cameraController;
  final Decoration? decoration;
  final ValueChanged<CameraImage>? onStream;

  static Route route() {
    return MaterialPageRoute<void>(
      builder: (_) => const CameraPage(),
      settings: const RouteSettings(name: cameraRouteName),
    );
  }

  @override
  State<CameraPage> createState() => _CameraPageSate();
}

class _CameraPageSate extends State<CameraPage> {
  @override
  Widget build(BuildContext context) {
    return CameraView(
      cameraController: widget.cameraController,
      decoration: widget.decoration,
      onStream: widget.onStream,
    );
  }
}
