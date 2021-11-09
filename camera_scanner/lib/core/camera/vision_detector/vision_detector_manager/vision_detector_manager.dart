import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:camera/camera.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'dart:developer' as developer;

import 'package:camera_scanner/core/camera/vision_detector/vision_detector.dart';

class VisionDetectorManager {
  VisionDetectorManager() : textDetector = GoogleMlKit.vision.textDetector();

  TextDetector textDetector;
  bool _isBusy = false;
  CustomPaint? customPaint;

  get isBusy => _isBusy;

  Future<void> processImage(CameraImage cameraImage) async {
    if (_isBusy) return;
    _isBusy = true;

    InputImage inputImage = _convertInputImage(cameraImage);

    final recognisedText = await textDetector.processImage(inputImage);
    developer.log('Found ${recognisedText.blocks.length} textBlocks');
    if (inputImage.inputImageData?.size != null &&
        inputImage.inputImageData?.imageRotation != null) {
      final painter = TextDetectorPainter(
          recognisedText,
          inputImage.inputImageData!.size,
          inputImage.inputImageData!.imageRotation);
      customPaint = CustomPaint(painter: painter);
    } else {
      customPaint = null;
    }
    _isBusy = false;
    // if (mounted) {
    //   setState(() {});
    // }
  }

  InputImage _convertInputImage(CameraImage cameraImage) {
    Uint8List planes = _concatenatePlanes(cameraImage.planes);
    InputImageRotation imageRotation = _rotationIntToImageRotation(0);
    InputImageData metaData = _buildMetaData(cameraImage, imageRotation);

    return InputImage.fromBytes(bytes: planes, inputImageData: metaData);
  }

  Uint8List _concatenatePlanes(List<Plane> planes) {
    final WriteBuffer allBytes = WriteBuffer();
    for (Plane plane in planes) {
      allBytes.putUint8List(plane.bytes);
    }
    return allBytes.done().buffer.asUint8List();
  }

  static InputImageData _buildMetaData(
    CameraImage image,
    InputImageRotation rotation,
  ) {
    return InputImageData(
      inputImageFormat: image.format.raw,
      size: Size(image.width.toDouble(), image.height.toDouble()),
      imageRotation: rotation,
      planeData: image.planes.map(
        (Plane plane) {
          return InputImagePlaneMetadata(
            bytesPerRow: plane.bytesPerRow,
            height: plane.height,
            width: plane.width,
          );
        },
      ).toList(),
    );
  }

  static InputImageRotation _rotationIntToImageRotation(int rotation) {
    switch (rotation) {
      case 0:
        return InputImageRotation.Rotation_0deg;
      case 90:
        return InputImageRotation.Rotation_90deg;
      case 180:
        return InputImageRotation.Rotation_180deg;
      default:
        assert(rotation == 270);
        return InputImageRotation.Rotation_270deg;
    }
  }
}
