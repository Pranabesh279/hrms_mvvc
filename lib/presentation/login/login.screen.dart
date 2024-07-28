import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:growit/shared/widgets/fill_button.dart';
import 'package:growit/shared/widgets/text_fields/email_field.dart';
import 'package:growit/shared/widgets/text_fields/password_field.dart';
import 'package:growit/infrastructure/theme/colors_data.dart';

import 'controllers/login.controller.dart';

class LoginScreen extends GetView<LoginController> {
  const LoginScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 20),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: SingleChildScrollView(
          child: Form(
            key: controller.fromKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      height: 60,
                      width: 60,
                      child: SvgPicture.asset('assets/logo.svg'),
                    ),
                    const SizedBox(width: 10),
                    const Spacer(),
                  ],
                ),
                const SizedBox(height: 60),
                Text(
                  'Get Started!',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: kTextColor,
                        fontSize: 24,
                      ),
                ),
                const SizedBox(height: 5),
                Text(
                  'Enter your organization email.',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Colors.grey,
                      ),
                ),
                const SizedBox(height: 20),
                Text(
                  'Enter your email',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: kTextColor,
                        fontSize: 12,
                      ),
                ),
                EmailField(
                  controller: controller.emailController,
                ),
                Obx(
                  () => controller.step.value == 0
                      ? Column(
                          children: [
                            const SizedBox(height: 40),
                            FillButton(
                              onPressed: () {
                                controller.validEmail();
                              },
                              isLoading: controller.isLoading.value,
                              child: bottonLoayout(),
                            ),
                          ],
                        )
                      : const SizedBox.shrink(),
                ),
                Obx(
                  () => controller.step.value == 1 &&
                          controller.isUserEmailExist.value
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 20),
                            Text(
                              'Password',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(
                                    color: kTextColor,
                                    fontSize: 12,
                                  ),
                            ),
                            PasswoardField(
                              controller: controller.passwordController,
                              hintText: 'Password',
                              validator: (p0) {
                                if (p0 == null || p0.isEmpty) {
                                  return 'Please enter password';
                                }
                                if (p0.length < 6) {
                                  return 'Password must be at least 6 characters';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            FillButton(
                              onPressed: () {
                                controller.signIn();
                              },
                              isLoading: controller.isLoading.value,
                              child: bottonLoayout(),
                            ),
                          ],
                        )
                      : const SizedBox.shrink(),
                ),
                Obx(
                  () => controller.step.value == 1 &&
                          !controller.isUserEmailExist.value
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 20),
                            Text(
                              'Password',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(
                                    color: kTextColor,
                                    fontSize: 12,
                                  ),
                            ),
                            PasswoardField(
                              controller: controller.passwordController,
                              hintText: 'Password',
                              validator: (p0) {
                                if (p0 == null || p0.isEmpty) {
                                  return 'Please enter password';
                                }
                                if (p0.length < 6) {
                                  return 'Password must be at least 6 characters';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 20),
                            Text(
                              'Confirm password',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(
                                    color: kTextColor,
                                    fontSize: 12,
                                  ),
                            ),
                            PasswoardField(
                              controller: controller.confirmPasswordController,
                              hintText: 'Confirm Password',
                              validator: (p0) {
                                if (p0 == null || p0.isEmpty) {
                                  return 'Please enter password';
                                }
                                if (p0 != controller.passwordController.text) {
                                  return 'Password does not match';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 40),
                            FillButton(
                              onPressed: () {
                                controller.signUp();
                              },
                              isLoading: controller.isLoading.value,
                              child: bottonLoayout(),
                            ),
                          ],
                        )
                      : const SizedBox.shrink(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  bottonLoayout() {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Next',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          width: 10,
        ),
        Icon(
          Icons.arrow_forward,
          color: Colors.white,
          size: 14,
        )
      ],
    );
  }
}
