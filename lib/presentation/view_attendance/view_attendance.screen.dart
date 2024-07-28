import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:growit/infrastructure/theme/colors_data.dart';

import 'controllers/view_attendance.controller.dart';

class ViewAttendanceScreen extends GetView<ViewAttendanceController> {
  const ViewAttendanceScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Attendance'),
        centerTitle: true,
      ),
      body: WeekView(
        // key: state,
        controller: controller.eventController,

        width: MediaQuery.of(context).size.width,
        showLiveTimeLineInAllDays: true,
        timeLineWidth: 65,
        liveTimeIndicatorSettings: const LiveTimeIndicatorSettings(
          color: kPrimaryColor,
          showTime: true,
        ),
        onEventTap: (events, date) {},
        onEventLongTap: (events, date) {
          // SnackBar snackBar = const SnackBar(content: Text("on LongTap"));
          // ScaffoldMessenger.of(context).showSnackBar(snackBar);
        },
      ),
    );
  }
}
