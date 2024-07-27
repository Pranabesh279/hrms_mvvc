import 'package:get/get.dart';

import '../../../../presentation/setup_profile/controllers/setup_profile.controller.dart';

class SetupProfileControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SetupProfileController>(
      () => SetupProfileController(),
    );
  }
}
