import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:growit/presentation/home/controllers/home.controller.dart';
import 'package:intl/intl.dart';

class PunchingAttendance extends GetView<HomeController> {
  const PunchingAttendance({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: Container(
          // height: 150,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    'Punch In',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const Spacer(),
                  Obx(
                    () => controller.isPunchedIn
                        ? const Icon(Icons.check_circle, color: Colors.green)
                        : Container(),
                  )
                ],
              ),
              Container(
                height: 1,
                width: 50,
                color: Colors.grey,
                margin: const EdgeInsets.symmetric(vertical: 10),
              ),
              const SizedBox(height: 10),
              Obx(() => Text(
                    controller.punchInTimeText,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Colors.grey,
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
              const SizedBox(
                height: 10,
              ),
              Obx(
                () => GestureDetector(
                  onTap: () {
                    if (!controller.isPunchedIn) {
                      controller.punchIn();
                    }
                  },
                  child: Container(
                    height: 30,
                    decoration: BoxDecoration(
                      color:
                          controller.isPunchedIn ? Colors.grey : Colors.green,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Center(
                        child: controller.isLoading.value
                            ? const CupertinoActivityIndicator()
                            : Text(
                                controller.isPunchedIn
                                    ? 'Checked In'
                                    : 'Punch In',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14,
                                    ),
                              )),
                  ),
                ),
              ),
            ],
          ),
        )),
        const SizedBox(
          width: 10,
        ),
        Expanded(
            child: Container(
          // height: 150,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    'Punch Out',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const Spacer(),
                  Obx(
                    () => controller.isPunchedOut
                        ? const Icon(Icons.check_circle, color: Colors.green)
                        : Container(),
                  )
                ],
              ),
              Container(
                height: 1,
                width: 50,
                color: Colors.grey,
                margin: const EdgeInsets.symmetric(vertical: 10),
              ),
              const SizedBox(height: 10),
              Obx(
                () => Text(
                  controller.punchOutTimeText,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                ),
              ),
              Text(
                DateFormat('dd MMMM').format(DateTime.now()).toUpperCase(),
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
              ),
              const SizedBox(
                height: 10,
              ),
              Obx(
                () => GestureDetector(
                  onTap: () {
                    if (!controller.isPunchedOut && controller.isPunchedIn) {
                      controller.punchOut();
                    }
                  },
                  child: Container(
                    height: 30,
                    decoration: BoxDecoration(
                      color: controller.isPunchedOut ? Colors.grey : Colors.red,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Center(
                      child: controller.isLoading.value
                          ? const CupertinoActivityIndicator()
                          : Text(
                              controller.isPunchedOut
                                  ? 'Cheacked out'
                                  : 'Punch Out',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                  ),
                            ),
                    ),
                  ),
                ),
              )
            ],
          ),
        )),
      ],
    );
  }
}
