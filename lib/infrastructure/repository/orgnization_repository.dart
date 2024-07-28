import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:growit/constants/constants.dart';

class OrgnizationRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<Map<String, dynamic>?> createOrgnizationByName(
      String name, emailIdentifier) async {
    final d = await _firestore
        .collection(ORGNIZATION)
        .where('emailIdentifier', isEqualTo: emailIdentifier)
        .get();

    if (d.docs.isNotEmpty) {
      return {
        'id': d.docs.first.id,
        'orgnizationName': d.docs.first['orgnizationName'],
        'emailIdentifier': d.docs.first['emailIdentifier']
      };
    }
    final doc = await _firestore
        .collection(ORGNIZATION)
        .add({'orgnizationName': name, 'emailIdentifier': emailIdentifier});
    return {
      'id': doc.id,
      'orgnizationName': name,
      'emailIdentifier': emailIdentifier
    };
  }
}
