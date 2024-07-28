import 'package:get/get.dart';

import '../../../../presentation/view_attendance/controllers/view_attendance.controller.dart';

class ViewAttendanceControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ViewAttendanceController>(
      () => ViewAttendanceController(),
    );
  }
}
