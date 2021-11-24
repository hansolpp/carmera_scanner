import 'dart:typed_data';
import 'dart:developer' as developer;

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:camera/camera.dart';
import 'package:google_ml_kit/google_ml_kit.dart';

import 'package:camera_scanner/core/camera/vision_detector/vision_detector.dart';
import 'package:camera_scanner/core/constants/constants.dart';

class VisionDetectorManager {
  VisionDetectorManager() : textDetector = GoogleMlKit.vision.textDetector();

  TextDetector textDetector;
  CustomPaint? customPaint;
  int beforeMilliSeconds = 0;
  bool _isBusy = false;

  get isBusy => _isBusy;

  Future<RecognisedText> processImage(CameraImage cameraImage) async {
    RecognisedText recognisedText =
        RecognisedText.fromMap({'text': '', 'blocks': []});

    int milliseconds = DateTime.now().millisecondsSinceEpoch;
    if (milliseconds - beforeMilliSeconds <= mlProcessingIntervalMillis) {
      return recognisedText;
    }
    beforeMilliSeconds = milliseconds;

    if (_isBusy) {
      return recognisedText;
    }
    _isBusy = true;

    InputImage inputImage = _convertInputImage(cameraImage);

    recognisedText = await textDetector.processImage(inputImage);
    if (recognisedText.text.isNotEmpty) {
      developer.log('Found ${recognisedText.blocks.length} textBlocks');
      developer.log('Found ${recognisedText.text}');
    }
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
    return recognisedText;
  }

  InputImage _convertInputImage(CameraImage cameraImage) {
    InputImageRotation imageRotation = _rotationIntToImageRotation(0);
    InputImageData metaData = _buildMetaData(cameraImage, imageRotation);
    Uint8List planes = _concatenatePlanes(cameraImage.planes);

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
    CameraImage cameraImage,
    InputImageRotation rotation,
  ) {
    final inputImageFormat =
        InputImageFormatMethods.fromRawValue(cameraImage.format.raw) ??
            InputImageFormat.NV21;

    final Size imageSize =
        Size(cameraImage.width.toDouble(), cameraImage.height.toDouble());

    final planeData = cameraImage.planes.map(
      (Plane plane) {
        return InputImagePlaneMetadata(
          bytesPerRow: plane.bytesPerRow,
          height: plane.height,
          width: plane.width,
        );
      },
    ).toList();

    return InputImageData(
      inputImageFormat: inputImageFormat,
      size: imageSize,
      imageRotation: rotation,
      planeData: planeData,
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
