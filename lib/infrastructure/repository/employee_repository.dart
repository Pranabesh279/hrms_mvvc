import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:growit/constants/constants.dart';
import 'package:growit/model/user/employee_response.dart';

class EmployeeRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<Employee?> getEmployeeById(String uuid) async {
    var doc = await _firestore.collection(EMPLOYEE_DB).doc(uuid).get();
    if (doc.exists) {
      return Employee.fromDocument(doc);
    }
    return null;
  }

  Future<bool> updateEmployee(String uuid,
      {required Map<String, dynamic> data}) async {
    log(uuid, name: 'uuid');
    log(data.toString(), name: 'data');
    try {
      await _firestore.collection(EMPLOYEE_DB).doc(uuid).update(data);
      return true;
    } catch (e) {
      return false;
    }
  }
}
