import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:growit/infrastructure/navigation/routes.dart';
import 'package:growit/infrastructure/repository/employee_repository.dart';
import 'package:growit/infrastructure/repository/orgnization_repository.dart';
import 'package:growit/infrastructure/services/auth_services.dart';
import 'package:growit/infrastructure/services/avatar_service.dart';
import 'package:growit/model/user/employee_response.dart';

class SetupProfileController extends GetxController {
  RxBool isLoading = false.obs;
  final formKey = GlobalKey<FormState>();
  Rx<String?> orgnizationName = Rx<String?>(null);
  TextEditingController orgnizationNameController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    orgnizationName.value = Get.arguments as String?;
    if (orgnizationName.value != null) {
      orgnizationNameController.text = orgnizationName.value!;
    }
  }

  void submit() async {
    if (formKey.currentState!.validate()) {
      isLoading.value = true;
      try {
        final organization = await OrgnizationRepository()
            .createOrgnizationByName(
                orgnizationNameController.text.trim(), orgnizationName.value);
        orgnizationNameController.text =
            organization?['orgnizationName'] ?? orgnizationNameController.text;
        Map<String, dynamic> data = {
          'name': nameController.text.trim(),
          'orgnizationId': organization?['id'],
          'orgnizationName': orgnizationNameController.text.trim(),
          'imageUrl': Get.find<AvatarService>().selectedAvatar.value,
        };
        final result = await EmployeeRepository().updateEmployee(
          Get.find<AuthService>().currentUser.value!.uid,
          data: data,
        );
        if (result) {
          Employee? employee = await EmployeeRepository()
              .getEmployeeById(Get.find<AuthService>().currentUser.value!.uid);
          Get.offAllNamed(Routes.HOME, arguments: employee?.toJson());
        }
      } catch (e) {
        log(e.toString());
      } finally {
        isLoading.value = false;
      }
    }
  }
}
