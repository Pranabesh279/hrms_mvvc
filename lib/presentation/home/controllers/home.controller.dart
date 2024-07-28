import 'dart:developer';

import 'package:get/get.dart';
import 'package:growit/infrastructure/navigation/bindings/controllers/authenticate_face.controller.binding.dart';
import 'package:growit/infrastructure/navigation/routes.dart';
import 'package:growit/infrastructure/repository/attendance_repository.dart';
import 'package:growit/infrastructure/repository/face_auth_repositroy.dart';
import 'package:growit/model/attendence/attendance_response.dart';
import 'package:growit/model/user/employee_response.dart';
import 'package:growit/presentation/authenticate_face/authenticate_face.screen.dart';
import 'package:intl/intl.dart';

class HomeController extends GetxController {
  RxBool isLoading = RxBool(false);
  Rx<Employee?> employee = Rx<Employee?>(null);
  Rx<DateTime?> punchInTime = Rx<DateTime?>(null);
  Rx<DateTime?> punchOutTime = Rx<DateTime?>(null);
  Rx<AttendanceResponse?> todaysAttendance = Rx<AttendanceResponse?>(null);
  Rx<List<AttendanceResponse>> attendanceList =
      Rx<List<AttendanceResponse>>([]);
  Rx<String> totalHours = Rx<String>('00:00');
  RxBool isFaceAuthRegistered = RxBool(false);

  @override
  void onInit() {
    super.onInit();
    checkFaceAuth();
    loadEmployee();
    todaysAttendance.bindStream(AttendanceRepository()
        .getAttendanceIdToday(userId: employee.value?.id ?? ""));
    ever(todaysAttendance, (AttendanceResponse? attendance) {
      log('todaysAttendance: ${todaysAttendance.value?.toJson()}');
      if (attendance != null) {
        punchInTime.value = todaysAttendance.value?.punchIn;
        punchOutTime.value = todaysAttendance.value?.punchOut;
      }
    });
    attendanceList.bindStream(AttendanceRepository()
        .getAttendanceByUserId(userId: employee.value?.id ?? ""));
    ever(attendanceList, (List<AttendanceResponse> attendanceList) {
      log('attendanceList: ${attendanceList.length}');
      if (attendanceList.isNotEmpty) {
        final total = attendanceList.fold(
            const Duration(),
            (previousValue, element) =>
                previousValue +
                (element.punchOut ?? DateTime.now())
                    .difference(element.punchIn ?? DateTime.now()));
        totalHours.value = total.toString().split('.').first.padLeft(8, '0');
        if (total.inMinutes < 0) {
          totalHours.value = '00:00';
        }
      }
    });
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

  void checkFaceAuth() async {
    try {
      isFaceAuthRegistered.value = await FaceAuthRepository().isregisteredUser(
        userId: employee.value?.id ?? "",
      );
      isFaceAuthRegistered.bindStream(FaceAuthRepository()
          .isregisteredUserStream(userId: employee.value?.id ?? ""));
    } catch (e) {
      log(e.toString());
    }
  }

  void punchIn() async {
    if (!isFaceAuthRegistered.value) return;
    final isAuthenticated = await Get.to<bool>(
      () => const AuthenticateFaceScreen(),
      binding: AuthenticateFaceControllerBinding(employee: employee.value),
    );
    log('isAuthenticated: $isAuthenticated');
    if ((isAuthenticated ?? false) == false) return;
    isLoading.value = true;
    try {
      final id = await AttendanceRepository().punchIn(
          userId: employee.value?.id ?? "",
          orgnizationId: employee.value!.orgnizationId);
      if (id != null) {
        log('Punched in');
      }
    } catch (e) {
      log(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  String get punchInTimeText {
    if (punchInTime.value != null) {
      return DateFormat('hh:mm a').format(punchInTime.value ?? DateTime.now());
    }
    return '00:00 AM';
  }

  String get punchOutTimeText {
    if (punchOutTime.value != null) {
      return DateFormat('hh:mm a').format(punchOutTime.value ?? DateTime.now());
    }
    return '00:00 AM';
  }

  bool get isPunchedIn {
    return punchInTime.value != null;
  }

  bool get isPunchedOut {
    return punchOutTime.value != null;
  }

  bool get isPunchOutEnabled {
    return isPunchedIn && !isPunchedOut;
  }

  String get totalTimeToady {
    if (isPunchedIn && isPunchedOut) {
      final total = punchOutTime.value!.difference(punchInTime.value!);
      return total.toString().split('.').first.padLeft(8, '0');
    }
    return '00:00';
  }

  void punchOut() async {
    if (!isFaceAuthRegistered.value) return;
    final isAuthenticated = await Get.to<bool>(
      () => const AuthenticateFaceScreen(),
      binding: AuthenticateFaceControllerBinding(employee: employee.value),
    );
    log('isAuthenticated: $isAuthenticated');
    if ((isAuthenticated ?? false) == false) return;
    isLoading.value = true;
    try {
      final isPunchedOut = await AttendanceRepository()
          .punchOut(id: todaysAttendance.value?.id ?? "");
      if (isPunchedOut) {
        log('Punched out');
      }
    } catch (e) {
      log(e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
