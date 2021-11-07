import 'package:camera_scanner/core/route/route_name.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CameraPage extends StatelessWidget {
  const CameraPage({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(
      builder: (_) => const CameraPage(),
      settings: const RouteSettings(name: cameraRouteName),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Align(
      alignment: Alignment.center,
      child: Text('test'),
    );
  }
}
