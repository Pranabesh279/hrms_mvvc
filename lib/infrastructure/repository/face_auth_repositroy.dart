import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:growit/constants/constants.dart';
import 'package:growit/model/facemodel/face_data.dart';

class FaceAuthRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<bool> isregisteredUser({required String userId}) async {
    try {
      final user = await _firestore
          .collection(FACE_DATA)
          .where('id', isEqualTo: userId)
          .get();
      log('user.docs.isNotEmpty: ${user.docs.isNotEmpty}');
      return user.docs.isNotEmpty;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  Stream<bool> isregisteredUserStream({required String userId}) {
    return _firestore
        .collection(FACE_DATA)
        .where('id', isEqualTo: userId)
        .snapshots()
        .map((event) => event.docs.isNotEmpty);
  }

  Future<void> registerUser({required Map<String, dynamic> data}) async {
    try {
      await _firestore.collection(FACE_DATA).add(data);
    } catch (e) {
      log(e.toString());
    }
  }

  Future<FaceData?> getFaceData({required String userId}) async {
    try {
      final user = await _firestore
          .collection(FACE_DATA)
          .where('id', isEqualTo: userId)
          .get();
      if (user.docs.isNotEmpty) {
        return FaceData.fromJson(user.docs.first.data());
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }
}
