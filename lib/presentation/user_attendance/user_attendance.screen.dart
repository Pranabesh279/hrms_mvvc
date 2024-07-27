import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'controllers/user_attendance.controller.dart';

class UserAttendanceScreen extends GetView<UserAttendanceController> {
  const UserAttendanceScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('UserAttendanceScreen'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'UserAttendanceScreen is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
