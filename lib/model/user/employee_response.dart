import 'package:cloud_firestore/cloud_firestore.dart';

class Employee {
  final String? id;
  final String? name;
  final String? email;
  final String? phone;
  final String? address;
  final String? position;
  final String? department;
  final String? salary;
  final String? status;

  Employee({
    this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.address,
    required this.position,
    required this.department,
    required this.salary,
    required this.status,
  });

  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      address: json['address'],
      position: json['position'],
      department: json['department'],
      salary: json['salary'],
      status: json['status'],
    );
  }

  factory Employee.fromDocument(DocumentSnapshot doc) {
    var json = doc.data() as Map<String, dynamic>;
    return Employee(
      id: doc.id,
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      address: json['address'],
      position: json['position'],
      department: json['department'],
      salary: json['salary'],
      status: json['status'],
    );
  }
}
