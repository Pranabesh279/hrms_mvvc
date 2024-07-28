import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_advanced_avatar/flutter_advanced_avatar.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:growit/infrastructure/services/auth_services.dart';
import 'package:growit/infrastructure/theme/colors_data.dart';
import 'package:growit/presentation/home/components/attendance_summery.dart';
import 'package:growit/presentation/home/components/punching_attendance.dart';

import 'controllers/home.controller.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(150),
        child: Container(
          padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [kPrimaryColor, kSecondaryColor],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 30,
                      width: 30,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: SvgPicture.asset('assets/logo.svg'),
                      ),
                    ),
                    const Spacer(),
                    InkWell(
                      onTap: () {
                        Get.find<AuthService>().signOut();
                      },
                      borderRadius: BorderRadius.circular(60),
                      child: Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        child: const Icon(
                          Icons.logout,
                          color: Colors.white,
                          size: 16,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Obx(() => Text(
                                (controller.employee.value?.orgnizationName ??
                                            '')
                                        .capitalizeFirst ??
                                    '',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w300,
                                      fontSize: 16,
                                    ),
                              )),
                          const SizedBox(height: 5),
                          Obx(() => Text(
                                "Hi, ${controller.employee.value?.name ?? ''}",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge
                                    ?.copyWith(
                                      color: Colors.white,
                                      fontSize: 24,
                                    ),
                              )),
                        ],
                      ),
                    ),
                    Obx(() => AdvancedAvatar(
                          size: 60,
                          name: controller.employee.value?.name ?? '',
                          decoration: const BoxDecoration(
                            color: kSecondaryColor,
                            shape: BoxShape.circle,
                          ),
                          animated: true,
                          image: NetworkImage(
                            controller.employee.value?.imageUrl ??
                                'https://www.pngitem.com/pimgs/m/146-1468479_my-profile-icon-blank-profile-picture-circle-hd.png',
                            scale: 1,
                          ),
                        )),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          children: [
            PunchingAttendance(),
            SizedBox(
              height: 10,
            ),
            AttendanceSummery()
          ],
        ),
      ),
    );
  }
}
