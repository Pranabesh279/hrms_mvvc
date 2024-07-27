import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:growit/infrastructure/shared/services/auth_services.dart';

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
        await auth.signInWithEmailAndPassword(
            emailController.text.trim(), passwordController.text.trim());
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
        await auth.signUpWithEmailAndPassword(
            emailController.text.trim(), confirmPasswordController.text.trim());
      } catch (e) {
        log(e.toString());
      } finally {
        isLoading.value = false;
      }
    }
  }
}
