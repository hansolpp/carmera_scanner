import 'package:flutter/material.dart';

import 'package:camera_scanner/core/route/route_name.dart';
import 'package:camera_scanner/app/pages/splash/home/camera_image_detector.dart';

class CameraImageDetectorPage extends StatefulWidget {
  const CameraImageDetectorPage({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(
      builder: (_) => const CameraImageDetectorPage(),
      settings: const RouteSettings(name: cameraImageDetectorRouteName),
    );
  }

  @override
  State<CameraImageDetectorPage> createState() =>
      _CameraImageDetectorPageState();
}

class _CameraImageDetectorPageState extends State<CameraImageDetectorPage> {
  @override
  Widget build(BuildContext context) {
    return const CameraImageDetectorView();
  }
}
