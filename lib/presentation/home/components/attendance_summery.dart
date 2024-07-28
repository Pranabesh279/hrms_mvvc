import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:growit/infrastructure/navigation/routes.dart';
import 'package:growit/infrastructure/theme/colors_data.dart';
import 'package:growit/presentation/home/controllers/home.controller.dart';
import 'package:intl/intl.dart';

class AttendanceSummery extends GetView<HomeController> {
  const AttendanceSummery({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'Attendance Summery',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ],
          ),
          Container(
            height: 1,
            width: 50,
            color: Colors.grey,
            margin: const EdgeInsets.symmetric(vertical: 10),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Total Time Today',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                  ),
                  Obx(() => Text(
                        controller.totalTimeToady,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: shed3,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                      )),
                  Text(
                    DateFormat('dd MMMM').format(DateTime.now()).toUpperCase(),
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                  ),
                ],
              ),
              const SizedBox(width: 20),
              // total hours worked
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Total Hours Worked',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                  ),
                  Obx(() => Text(
                        controller.totalHours.value,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: kSecondaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                      )),
                ],
              ),
            ],
          ),
          // view all attendance
          const SizedBox(height: 10),
          Divider(
            color: Colors.grey.shade100,
            height: 1,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TextButton(
                onPressed: () {
                  Get.toNamed(Routes.VIEW_ATTENDANCE,
                      arguments: controller.employee.value?.toJson());
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'View All Attendance',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: kPrimary,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                    ),
                    const SizedBox(width: 5),
                    Icon(
                      Icons.arrow_forward,
                      color: kPrimary,
                      size: 12,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
