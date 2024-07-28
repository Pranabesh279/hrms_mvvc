import 'dart:convert';
import 'dart:developer';
import 'dart:ffi';
import 'dart:math' as math;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:growit/infrastructure/repository/face_auth_repositroy.dart';
import 'package:growit/model/facemodel/face_data.dart';
import 'package:growit/model/facemodel/face_features.dart';
import 'package:flutter_face_api/face_api.dart' as regula;
import 'package:growit/model/user/employee_response.dart';

class AuthenticateFaceController extends GetxController {
  Employee? employee;
  AuthenticateFaceController({required this.employee});
  final FaceDetector faceDetector = FaceDetector(
    options: FaceDetectorOptions(
      enableLandmarks: true,
      performanceMode: FaceDetectorMode.accurate,
    ),
  );
  Rx<FaceFeatures?> faceFeatures = Rx<FaceFeatures?>(null);
  var image1 = regula.MatchFacesImage();
  var image2 = regula.MatchFacesImage();

  RxBool canAuthenticate = false.obs;
  Rx<String> similarity = "".obs;
  Rx<FaceData?> user = Rx<FaceData?>(null);
  RxBool userExists = false.obs;
  RxBool isMatching = false.obs;
  // Rx<int> trialNumber = 1.obs;

  @override
  void onInit() {
    super.onInit();
    loadEmployee();
  }

  void loadEmployee() {
    try {
      final empJson = Get.arguments as Map<String, dynamic>?;
      if (empJson != null) {
        employee = Employee.fromJson(empJson);
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Future setImage(Uint8List imageToAuthenticate) async {
    image2.bitmap = base64Encode(imageToAuthenticate);
    image2.imageType = regula.ImageType.PRINTED;
    canAuthenticate.value = true;
  }

  double compareFaces(FaceFeatures face1, FaceFeatures face2) {
    double distEar1 = euclideanDistance(face1.rightEar!, face1.leftEar!);
    double distEar2 = euclideanDistance(face2.rightEar!, face2.leftEar!);

    double ratioEar = distEar1 / distEar2;

    double distEye1 = euclideanDistance(face1.rightEye!, face1.leftEye!);
    double distEye2 = euclideanDistance(face2.rightEye!, face2.leftEye!);

    double ratioEye = distEye1 / distEye2;

    double distCheek1 = euclideanDistance(face1.rightCheek!, face1.leftCheek!);
    double distCheek2 = euclideanDistance(face2.rightCheek!, face2.leftCheek!);

    double ratioCheek = distCheek1 / distCheek2;

    double distMouth1 = euclideanDistance(face1.rightMouth!, face1.leftMouth!);
    double distMouth2 = euclideanDistance(face2.rightMouth!, face2.leftMouth!);

    double ratioMouth = distMouth1 / distMouth2;

    double distNoseToMouth1 =
        euclideanDistance(face1.noseBase!, face1.bottomMouth!);
    double distNoseToMouth2 =
        euclideanDistance(face2.noseBase!, face2.bottomMouth!);

    double ratioNoseToMouth = distNoseToMouth1 / distNoseToMouth2;

    double ratio =
        (ratioEye + ratioEar + ratioCheek + ratioMouth + ratioNoseToMouth) / 5;
    log(ratio.toString(), name: "Ratio");

    return ratio;
  }

  // A function to calculate the Euclidean distance between two points
  double euclideanDistance(Points p1, Points p2) {
    final sqr =
        math.sqrt(math.pow((p1.x! - p2.x!), 2) + math.pow((p1.y! - p2.y!), 2));
    return sqr;
  }

  fetchUsersAndMatchFace() async {
    await FaceAuthRepository().getFaceData(userId: employee!.id!).then((value) {
      if (value != null) {
        userExists.value = true;
        user.value = value;

        // image1.bitmap = value.image;
        // image1.imageType = regula.ImageType.PRINTED;
        _matchFaces();
      } else {
        userExists.value = false;
        showToast(
            "User is not registered yet. Register first to authenticate.");
      }
    });
  }

  _matchFaces() async {
    bool faceMatched = false;
    image1.bitmap = (user.value as FaceData).image;
    image1.imageType = regula.ImageType.PRINTED;
    var request = regula.MatchFacesRequest();
    request.images = [image1, image2];
    dynamic value = await regula.FaceSDK.matchFaces(jsonEncode(request));
    var response = regula.MatchFacesResponse.fromJson(json.decode(value));
    dynamic str = await regula.FaceSDK.matchFacesSimilarityThresholdSplit(
        jsonEncode(response!.results), 0.75);
    var split =
        regula.MatchFacesSimilarityThresholdSplit.fromJson(json.decode(str));
    similarity.value = split!.matchedFaces.isNotEmpty
        ? (split.matchedFaces[0]!.similarity! * 100).toStringAsFixed(2)
        : "error";
    log("similarity: ${similarity.value}");
    if (similarity.value != "error" && double.parse(similarity.value) > 90.00) {
      faceMatched = true;
    } else {
      faceMatched = false;
    }
    log('similarity: ${similarity.value}');
    log('faceMatched: $faceMatched');
    if (faceMatched) {
      isMatching.value = false;
      Get.back(result: true);
    } else {
      isMatching.value = false;
      Get.back(result: false);
    }
  }

  void showToast(msg) {
    log(msg);
  }
}
