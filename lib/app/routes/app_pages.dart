import 'package:get/get.dart';

import '../modules/cameraview/bindings/cameraview_binding.dart';
import '../modules/cameraview/views/cameraview_view.dart';
import '../modules/forgot_password/bindings/forgot_password_binding.dart';
import '../modules/forgot_password/views/forgot_password_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/otp_verification/bindings/otp_verification_binding.dart';
import '../modules/otp_verification/views/otp_verification_view.dart';
import '../modules/pakaian/bindings/pakaian_binding.dart';
import '../modules/pakaian/views/pakaian_view.dart';
import '../modules/register/bindings/register_binding.dart';
import '../modules/register/views/register_view.dart';
import '../modules/set_new_password/bindings/set_new_password_binding.dart';
import '../modules/set_new_password/views/set_new_password_view.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/splash_view.dart';
import '../modules/streamlit/bindings/streamlit_binding.dart';
import '../modules/streamlit/views/streamlit_view.dart';
import '../modules/verify_reset/bindings/verify_reset_binding.dart';
import '../modules/verify_reset/views/verify_reset_view.dart';
import 'app_routes.dart';

class AppPages {
  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: Routes.SPLASH,
      page: () => SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
        name: Routes.LOGIN, page: () => LoginPage(), binding: LoginBinding()),
    GetPage(
        name: Routes.REGISTER,
        page: () => RegisterPage(),
        binding: RegisterBinding()),
    GetPage(name: Routes.HOME, page: () => HomePage(), binding: HomeBinding()),
    GetPage(
        name: Routes.FORGOT_PASSWORD,
        page: () => ForgotPasswordView(),
        binding: ForgotPasswordBinding()),
    GetPage(
        name: Routes.OTP_VERIFICATION,
        page: () => OtpVerificationView(),
        binding: OtpVerificationBinding()),
    GetPage(
      name: Routes.FORGOT_PASSWORD,
      page: () => ForgotPasswordView(),
      binding: ForgotPasswordBinding(),
    ),
    GetPage(
      name: Routes.VERIFY_RESET,
      page: () => VerifyResetView(),
      binding: VerifyResetBinding(),
    ),
    GetPage(
      name: Routes.SET_NEW_PASSWORD,
      page: () => SetNewPasswordView(),
      binding: SetNewPasswordBinding(),
    ),
    GetPage(
      name: Routes.CAMERAVIEW,
      page: () => CameraviewView(),
      binding: CameraviewBinding(),
    ),
    GetPage(
        name: Routes.STREAMLIT,
        page: () => StreamlitView(),
        binding: StreamlitBinding()
    ),
    // nanti tambahin halaman Home kalau mau
    GetPage(
      name: Routes.PAKAIAN,
      page: () => PakaianView(),
      binding: PakaianBinding(),
    ),
  ];
}
