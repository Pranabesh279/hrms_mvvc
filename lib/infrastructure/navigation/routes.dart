class Routes {
  static Future<String> get initialRoute async {
    return SPLASH;
  }

  static const HOME = '/home';
  static const LOGIN = '/login';
  static const REGISTER = '/register';
  static const REGISTER_FACE = '/register-face';
  static const SETUP_PROFILE = '/setup-profile';
  static const SPLASH = '/splash';
  static const USER_ATTENDANCE = '/user-attendance';
  static const VIEW_ATTENDANCE = '/view-attendance';
  static const AUTHENTICATE_FACE = '/authenticate-face';
}
