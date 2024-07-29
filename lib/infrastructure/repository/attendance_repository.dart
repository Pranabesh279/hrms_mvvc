import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:growit/constants/constants.dart';
import 'package:growit/model/attendence/attendance_response.dart';
import 'package:intl/intl.dart';

class AttendanceRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String?> punchIn({required String userId, orgnizationId}) async {
    final doc = await _firestore.collection(EMPLOYEE_ATTENDENCE).add({
      'userId': userId,
      'orgnizationId': orgnizationId,
      'punchIn': FieldValue.serverTimestamp(),
      'punchOut': null,
      'type': AttendenceType.PUNCH_IN,
      'date': DateFormat('yyyy-MM-dd').format(DateTime.now())
    });
    return doc.id;
  }

  Future<bool> punchOut({required String id}) async {
    try {
      await _firestore.collection(EMPLOYEE_ATTENDENCE).doc(id).update({
        'punchOut': FieldValue.serverTimestamp(),
        'type': AttendenceType.PUNCH_OUT
      });
      return true;
    } catch (e) {
      return false;
    }
  }

  Stream<AttendanceResponse?> getAttendanceIdToday({required String userId}) {
    return _firestore
        .collection(EMPLOYEE_ATTENDENCE)
        .where('userId', isEqualTo: userId)
        .where('date',
            isEqualTo: DateFormat('yyyy-MM-dd').format(DateTime.now()))
        .snapshots()
        .map((event) {
      if (event.docs.isNotEmpty) {
        log('AttendanceRepository: ${event.docs.first.data()}');
        return AttendanceResponse.fromDocument(event.docs.first);
      }
      return null;
    });
  }

  Stream<List<AttendanceResponse>> getAttendanceByUserId(
      {required String userId}) {
    return _firestore
        .collection(EMPLOYEE_ATTENDENCE)
        .where('userId', isEqualTo: userId)
        .snapshots()
        .map((event) {
      return event.docs.map((e) => AttendanceResponse.fromDocument(e)).toList();
    });
  }

  Future<List<AttendanceResponse>> getAttendanceByUser({
    required String userId,
  }) async {
    final snapshot = await _firestore
        .collection(EMPLOYEE_ATTENDENCE)
        .where('userId', isEqualTo: userId)
        .get();
    return snapshot.docs
        .map((e) => AttendanceResponse.fromDocument(e))
        .toList();
  }
}
