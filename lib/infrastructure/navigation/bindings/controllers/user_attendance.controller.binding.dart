import 'package:get/get.dart';

import '../../../../presentation/user_attendance/controllers/user_attendance.controller.dart';

class UserAttendanceControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserAttendanceController>(
      () => UserAttendanceController(),
    );
  }
}
