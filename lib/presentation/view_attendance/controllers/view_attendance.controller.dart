import 'dart:developer';

import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:growit/infrastructure/repository/attendance_repository.dart';
import 'package:growit/model/user/employee_response.dart';
import 'package:intl/intl.dart';

class ViewAttendanceController extends GetxController {
  EventController eventController = EventController();
  Rx<Employee?> employee = Rx<Employee?>(null);

  @override
  void onInit() {
    super.onInit();
    loadEmployee();
    loadEvents();
  }

  void loadEmployee() {
    try {
      final empJson = Get.arguments as Map<String, dynamic>?;
      if (empJson != null) {
        employee.value = Employee.fromJson(empJson);
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Future loadEvents() async {
    try {
      final attendanceList = await AttendanceRepository()
          .getAttendanceByUser(userId: employee.value?.id ?? "");
      for (var attendance in attendanceList) {
        if (attendance.punchIn == null || attendance.punchOut == null) {
          continue;
        }
        eventController.add(
          CalendarEventData(
              title:
                  '${DateFormat('hh:mm a').format(attendance.punchIn!)} - ${DateFormat('hh:mm a').format(attendance.punchOut!)}',
              date: attendance.punchIn!,
              // startTime: attendance.punchIn!,
              // endTime: attendance.punchOut!,
              color: Colors.green,
              endDate: attendance.punchOut!,
              event: attendance.toJson()),
        );
      }

      eventController.add(
        CalendarEventData(
          title: 'Today',
          date: DateTime.now(),
          startTime: DateTime.now(),
          endTime: DateTime.now(),
          color: Colors.red,
          endDate: DateTime.now(),
          event: const {'type': 'today'},
        ),
      );
    } catch (e) {
      // Handle error
    }
  }
}
