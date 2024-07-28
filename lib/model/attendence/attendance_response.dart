import 'package:cloud_firestore/cloud_firestore.dart';

class AttendanceResponse {
  final String? id;
  final String? userId;
  final String? orgnizationId;
  final DateTime? punchIn;
  final DateTime? punchOut;

  AttendanceResponse({
    this.id,
    required this.userId,
    this.orgnizationId,
    this.punchIn,
    this.punchOut,
  });

  factory AttendanceResponse.fromDocument(DocumentSnapshot doc) {
    var snapshot = doc.data() as Map<String, dynamic>;
    return AttendanceResponse(
      id: doc.id,
      userId: snapshot['userId'],
      orgnizationId: snapshot['orgnizationId'],
      punchIn: snapshot['punchIn']?.toDate(),
      punchOut: snapshot['punchOut']?.toDate(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'orgnizationId': orgnizationId,
      'punchIn': punchIn,
      'punchOut': punchOut,
    };
  }
}
