import 'package:entry/entry.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:get/get.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:growit/infrastructure/services/auth_services.dart';
import 'package:growit/infrastructure/services/avatar_service.dart';
import 'package:growit/infrastructure/theme/colors_data.dart';
import 'package:growit/shared/input_style.dart';
import 'package:growit/shared/widgets/fill_button.dart';
import 'controllers/setup_profile.controller.dart';
import 'package:flutter_advanced_avatar/flutter_advanced_avatar.dart';

class SetupProfileScreen extends GetView<SetupProfileController> {
  const SetupProfileScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
          margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 20),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: SingleChildScrollView(
            child: Form(
              key: controller.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Choose your avatar',
                          style:
                              Theme.of(context).textTheme.titleLarge?.copyWith(
                                    color: kTextColor,
                                    fontSize: 24,
                                  ),
                        ),
                      ),
                      Expanded(
                        child: CarouselSlider(
                          options: CarouselOptions(
                            height: 100,
                            viewportFraction: 0.3,
                            initialPage: 0,
                            enableInfiniteScroll: true,
                            autoPlayInterval: const Duration(seconds: 3),
                            autoPlayAnimationDuration:
                                const Duration(milliseconds: 800),
                            autoPlayCurve: Curves.fastOutSlowIn,
                            pageSnapping: false,
                            enlargeCenterPage: true,
                            enlargeFactor: 0.5,
                            scrollDirection: Axis.horizontal,
                            onPageChanged: (index, reason) {
                              Get.find<AvatarService>().selectedAvatar.value =
                                  Get.find<AvatarService>().avatarUrls[index];
                            },
                          ),
                          items: Get.find<AvatarService>().avatarUrls.map((i) {
                            return Builder(
                              builder: (BuildContext context) {
                                return Obx(() => AdvancedAvatar(
                                      size: 45,
                                      decoration: const BoxDecoration(
                                        color: Colors.white,
                                        shape: BoxShape.circle,
                                      ),
                                      statusColor: Get.find<AvatarService>()
                                                  .selectedAvatar
                                                  .value ==
                                              i
                                          ? Colors.green
                                          : null,
                                      animated: true,
                                      image: NetworkImage(i),
                                    ));
                              },
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Obx(() => controller.orgnizationName.value == null
                      ? const SizedBox()
                      : Entry.scale(
                          child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Enter your orgnization name',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(
                                    color: kTextColor,
                                    fontSize: 12,
                                  ),
                            ),
                            TextFormField(
                              // initialValue: controller.orgnizationName.value,
                              keyboardType: TextInputType.name,
                              controller: controller.orgnizationNameController,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge
                                  ?.copyWith(
                                    color: kTextColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter orgnization name';
                                }

                                return null;
                              },
                              decoration: FieldDecoration(
                                hintText: 'ex : grow pvt ltd',
                                hintStyle: Theme.of(context)
                                    .textTheme
                                    .titleLarge
                                    ?.copyWith(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w600,
                                    ),
                              ).kInputDecoration,
                            ),
                            const SizedBox(
                              height: 10,
                            )
                          ],
                        ))),
                  Text(
                    'Enter your name',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: kTextColor,
                          fontSize: 12,
                        ),
                  ),
                  TextFormField(
                    autofocus: true,
                    controller: controller.nameController,
                    keyboardType: TextInputType.name,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: kTextColor,
                          fontWeight: FontWeight.w600,
                        ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter name';
                      }

                      return null;
                    },
                    decoration: FieldDecoration(
                      hintText: 'ex : John Doe',
                      hintStyle:
                          Theme.of(context).textTheme.titleLarge?.copyWith(
                                color: Colors.grey,
                                fontWeight: FontWeight.w600,
                              ),
                    ).kInputDecoration,
                  ),
                  // login button
                  const SizedBox(height: 40),
                  Obx(() => FillButton(
                        onPressed: () {
                          controller.submit();
                        },
                        isLoading: controller.isLoading.value,
                        child: const Text(
                          'Lets gets start !',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      )),
                ],
              ),
            ),
          )),
    );
  }
}
