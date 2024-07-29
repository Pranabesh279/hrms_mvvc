import 'package:get/get.dart';

import '../../../../presentation/register_face/controllers/register_face.controller.dart';

class RegisterFaceControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RegisterFaceController>(
      () => RegisterFaceController(),
    );
  }
}
