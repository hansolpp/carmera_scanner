import 'package:flutter/material.dart';

import 'package:camera_scanner/app/pages/splash/home/camera_image_detector.dart';

class MlCameraApp extends StatefulWidget {
  const MlCameraApp({Key? key}) : super(key: key);

  @override
  State<MlCameraApp> createState() => _MlCameraApp();
}

class _MlCameraApp extends State<MlCameraApp> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CameraImageDetectorPage(),
    );
  }
}
