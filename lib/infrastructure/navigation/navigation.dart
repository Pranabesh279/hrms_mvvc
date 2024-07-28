import 'package:get/get.dart';

import '../../presentation/screens.dart';
import 'bindings/controllers/controllers_bindings.dart';
import 'routes.dart';

class Nav {
  static List<GetPage> routes = [
    GetPage(
      name: Routes.HOME,
      page: () => const HomeScreen(),
      binding: HomeControllerBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: Routes.LOGIN,
      page: () => const LoginScreen(),
      binding: LoginControllerBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: Routes.SPLASH,
      page: () => const SplashScreen(),
      binding: SplashControllerBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: Routes.SETUP_PROFILE,
      page: () => const SetupProfileScreen(),
      binding: SetupProfileControllerBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: Routes.VIEW_ATTENDANCE,
      page: () => const ViewAttendanceScreen(),
      binding: ViewAttendanceControllerBinding(),
    ),
    GetPage(
      name: Routes.REGISTER_FACE,
      page: () => const RegisterFaceScreen(),
      binding: RegisterFaceControllerBinding(),
    ),
    GetPage(
      name: Routes.AUTHENTICATE_FACE,
      page: () => const AuthenticateFaceScreen(),
      binding: AuthenticateFaceControllerBinding(),
    ),
  ];
}
