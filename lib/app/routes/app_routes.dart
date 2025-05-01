abstract class Routes {
  Routes._();
  static const HOME = _Paths.HOME;
  static const LOGIN = _Paths.LOGIN;
  static const REGISTER = _Paths.REGISTER;
  static const SPLASH = _Paths.SPLASH;
  static const FORGOT_PASSWORD = _Paths.FORGOT_PASSWORD;
  static const OTP_VERIFICATION = _Paths.OTP_VERIFICATION;
  static const VERIFY_RESET = _Paths.VERIFY_RESET;
  static const SET_NEW_PASSWORD = _Paths.SET_NEW_PASSWORD;
}

abstract class _Paths {
  _Paths._();
  static const HOME = '/home';
  static const LOGIN = '/login';
  static const REGISTER = '/register';
  static const SPLASH = '/';
  static const FORGOT_PASSWORD = '/forgot-password';
  static const OTP_VERIFICATION = '/otp-verification';
  static const VERIFY_RESET = '/verify-reset';
  static const SET_NEW_PASSWORD = '/set-new-password';
}
