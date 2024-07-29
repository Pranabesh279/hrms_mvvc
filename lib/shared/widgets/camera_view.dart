import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:image_picker/image_picker.dart';

class CameraView extends StatefulWidget {
  const CameraView(
      {super.key,
      required this.onImage,
      required this.onInputImage,
      this.child,
      required this.onCameraError});

  final Function(Uint8List image) onImage;
  final Function(InputImage inputImage) onInputImage;
  final VoidCallback onCameraError;
  final Widget? child;

  @override
  State<CameraView> createState() => _CameraViewState();
}

class _CameraViewState extends State<CameraView> {
  File? _image;
  ImagePicker? _imagePicker;

  @override
  void initState() {
    super.initState();
    _imagePicker = ImagePicker();
    _getImage();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: _image == null
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              width: double.infinity,
              color: Colors.white,
              child: Column(
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      margin: EdgeInsets.only(
                          top: MediaQuery.of(context).padding.top + 20,
                          bottom: 10),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.file(
                            _image!,
                            fit: BoxFit.cover,
                          )),
                    ),
                  ),
                  Expanded(
                    child: widget.child ?? Container(),
                  ),
                ],
              ),
            ),
    );
  }

  Future _getImage() async {
    try {
      setState(() {
        _image = null;
      });
      final pickedFile = await _imagePicker?.pickImage(
        source: ImageSource.camera,
        maxWidth: 400,
        maxHeight: 400,
        preferredCameraDevice: CameraDevice.front,
        // imageQuality: 50,
      );
      if (pickedFile != null) {
        _setPickedFile(pickedFile);
      } else {
        widget.onCameraError();
      }
      setState(() {});
    } catch (e) {
      widget.onCameraError();
    }
  }

  Future _setPickedFile(XFile? pickedFile) async {
    try {
      final path = pickedFile?.path;
      if (path == null) {
        return;
      }
      setState(() {
        _image = File(path);
      });

      Uint8List imageBytes = _image!.readAsBytesSync();
      widget.onImage(imageBytes);

      InputImage inputImage = InputImage.fromFilePath(path);
      widget.onInputImage(inputImage);
    } catch (e) {
      widget.onCameraError();
    }
  }
}
