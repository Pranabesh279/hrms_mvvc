import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:growit/infrastructure/navigation/routes.dart';
import 'package:growit/infrastructure/repository/employee_repository.dart';
import 'package:growit/infrastructure/services/auth_services.dart';
import 'package:growit/model/user/employee_response.dart';

class LoginController extends GetxController {
  RxBool isLoading = false.obs;
  final fromKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  AuthService auth = Get.find<AuthService>();
  RxBool isUserEmailExist = false.obs;
  Rx<int> step = 0.obs;

  void validEmail() async {
    if (fromKey.currentState!.validate()) {
      isLoading.value = true;
      try {
        isUserEmailExist.value =
            await auth.isEmailExist(emailController.text.trim());
        log(isUserEmailExist.value.toString(), name: 'isUserEmailExist');
        step.value = 1;
      } catch (e) {
        log(e.toString());
      } finally {
        isLoading.value = false;
      }
    }
  }

  void signIn() async {
    if (fromKey.currentState!.validate()) {
      isLoading.value = true;
      try {
        final user = await auth.signInWithEmailAndPassword(
            emailController.text.trim(), passwordController.text.trim());
        redirectPage(user?.uid);
      } catch (e) {
        log(e.toString());
      } finally {
        isLoading.value = false;
      }
    }
  }

  void signUp() async {
    if (fromKey.currentState!.validate()) {
      isLoading.value = true;
      try {
        final user = await auth.signUpWithEmailAndPassword(
            emailController.text.trim(), confirmPasswordController.text.trim());
        redirectPage(user?.uid);
      } catch (e) {
        log(e.toString());
      } finally {
        isLoading.value = false;
      }
    }
  }

  Future<void> redirectPage(String? uuid) async {
    if (uuid == null) return;
    Employee? employee = await EmployeeRepository().getEmployeeById(uuid);
    if (employee != null) {
      if (employee.name != null) {
        Get.offAllNamed(Routes.HOME, arguments: employee.toJson());
      } else {
        Get.offAllNamed(Routes.SETUP_PROFILE,
            arguments: employee.orgnizationName);
      }
    }
  }
}
