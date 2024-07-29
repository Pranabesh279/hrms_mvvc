import 'package:get/get.dart';
import 'package:growit/model/user/employee_response.dart';

import '../../../../presentation/authenticate_face/controllers/authenticate_face.controller.dart';

class AuthenticateFaceControllerBinding extends Bindings {
  Employee? employee;
  AuthenticateFaceControllerBinding({this.employee});
  @override
  void dependencies() {
    Get.lazyPut<AuthenticateFaceController>(
      () => AuthenticateFaceController(
        employee: employee,
      ),
    );
  }
}
