import 'dart:developer';

import 'package:get/get.dart';
import 'package:growit/infrastructure/navigation/routes.dart';
import 'package:growit/infrastructure/repository/employee_repository.dart';
import 'package:growit/infrastructure/services/auth_services.dart';
import 'package:growit/model/user/employee_response.dart';

class SplashController extends GetxController {
  AuthService auth = Get.find<AuthService>();
  RxBool isLoading = true.obs;
  @override
  void onInit() {
    super.onInit();
    log('SplashController onInit');
    checkUser();
  }

  Future<void> checkUser() async {
    await Future.delayed(const Duration(seconds: 2));
    if (auth.currentUser.value != null) {
      Employee? employee = await EmployeeRepository()
          .getEmployeeById(auth.currentUser.value!.uid);
      if (employee != null) {
        if (employee.name != null) {
          Get.offAllNamed(Routes.HOME, arguments: employee.toJson());
        } else {
          Get.offAllNamed(Routes.SETUP_PROFILE,
              arguments: employee.orgnizationName);
        }
      } else {
        Get.offAllNamed(Routes.LOGIN);
      }
    } else {
      log('User is not logged in');
      Get.offAllNamed(Routes.LOGIN);
    }
    isLoading.value = false;
  }
}
