import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:growit/infrastructure/repository/face_auth_repositroy.dart';
import 'package:growit/model/facemodel/face_data.dart';
import 'package:growit/model/facemodel/face_features.dart';
import 'package:growit/model/user/employee_response.dart';

class RegisterFaceController extends GetxController {
  Rx<Employee?> employee = Rx<Employee?>(null);
  final FaceDetector faceDetector = FaceDetector(
    options: FaceDetectorOptions(
      enableLandmarks: true,
      performanceMode: FaceDetectorMode.accurate,
    ),
  );
  Rx<String?> image = Rx<String?>(null);
  Rx<FaceFeatures?> faceFeatures = Rx<FaceFeatures?>(null);

  Rx<bool> isRegistering = Rx<bool>(false);

  @override
  void onInit() {
    super.onInit();
    loadEmployee();
  }

  void loadEmployee() {
    try {
      final empJson = Get.arguments as Map<String, dynamic>?;
      if (empJson != null) {
        employee.value = Employee.fromJson(empJson);
      }
    } catch (e) {
      log(e.toString());
    }
  }

  registeryourFace() async {
    isRegistering.value = true;
    try {
      FaceData faceData = FaceData(
        id: employee.value?.id,
        name: employee.value?.name,
        image: image.value,
        faceFeatures: faceFeatures.value,
        registeredOn: Timestamp.now(),
      );
      await FaceAuthRepository().registerUser(data: faceData.toJson());
      Future.delayed(1.seconds, () {
        Get.back();
      });
    } catch (e) {
      log(e.toString());
    } finally {
      isRegistering.value = false;
    }
  }
}
