import 'dart:convert';
import 'dart:developer';

import 'package:entry/entry.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:growit/infrastructure/services/extract_features.dart';
import 'package:growit/shared/widgets/camera_view.dart';

import 'controllers/register_face.controller.dart';

class RegisterFaceScreen extends GetView<RegisterFaceController> {
  const RegisterFaceScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CameraView(
        onCameraError: () {
          Get.back();
        },
        onImage: (image) {
          log('Image: $image');
          controller.image.value = base64Encode(image);
        },
        onInputImage: (inputImage) async {
          await extractFaceFeatures(inputImage, controller.faceDetector)
              .then((faceFeatures) {
            controller.faceFeatures.value = faceFeatures;
            controller.registeryourFace();
          });
        },
        child: Column(
          children: [
            Entry.all(
              duration: const Duration(milliseconds: 400),
              child: Container(
                height: 80,
                width: 80,
                padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                  color: Colors.green,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.check, color: Colors.white, size: 50),
              ),
            ),
            const SizedBox(height: 20),
            Entry.all(
              duration: const Duration(milliseconds: 600),
              child: Text(
                'Register your face',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            const SizedBox(height: 10),
            Obx(() => controller.isRegistering.value
                ? Entry.all(
                    duration: const Duration(milliseconds: 200),
                    child: Text(
                      'Registering your face...',
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(color: Colors.grey, fontSize: 12),
                    ),
                  )
                : Entry.all(
                    duration: const Duration(milliseconds: 200),
                    child: Text(
                      'Please make sure your face is clearly visible',
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(color: Colors.grey, fontSize: 12),
                    ),
                  )),
          ],
        ),
      ),
    );
  }
}
