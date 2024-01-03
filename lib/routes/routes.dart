import 'package:get/get.dart';
import 'package:trends_hub/screens/addresspage/address_page.dart';
import 'package:trends_hub/screens/camerapage/camera_page.dart';
import 'package:trends_hub/screens/homepage/homepage.dart';
import 'package:trends_hub/screens/homepage/root_binding.dart';
import 'package:trends_hub/screens/imagespage/images_page.dart';
import 'package:trends_hub/screens/login/login_binding.dart';
import 'package:trends_hub/screens/login/loginpage.dart';
import 'package:trends_hub/screens/profile/profile_controller.dart';
import 'package:trends_hub/screens/profile/profile_page.dart';
import 'package:trends_hub/screens/signup/signup_binding.dart';
import 'package:trends_hub/screens/signup/signuppage.dart';
import 'package:trends_hub/services/auth_middleware.dart';

class AppRoutes {
  static String initialRoute = "/";
  static String loginRoute = "/loginRoute";
  static String signUpRoute = "/signUpRoute";
  static String homePage = "/homePage";
  static String imagesPage = "/imagesPage";
  static String cameraPage = "/cameraPage";
  static String profilePage = "/profilePage";
  static String addressPage = '/addressPage';

  static List<GetPage> routes = [
    // GetPage(name: initialRoute, page: () => const HomePage()),
    GetPage(
        name: loginRoute,
        page: () => const LoginPage(),
        binding: LoginBindings()),
    GetPage(
        name: signUpRoute,
        page: () => const SignupPage(),
        binding: SignupBindings()),

    GetPage(
        name: imagesPage,
        page: () => const ImagesPage(),
        binding: RootBinding()),
    GetPage(
        name: cameraPage,
        page: () => const CameraPage(),
        binding: RootBinding()),
    GetPage(
        name: profilePage,
        page: () => const ProfilePage(),
        binding: RootBinding()),
    GetPage(
        name: addressPage,
        page: () => AddressPage(),
        binding: RootBinding(),
        middlewares: [AuthMiddleware()]),
    GetPage(
      name: homePage,
      page: () => const HomePage(),
      binding: RootBinding(),
      // middlewares: [AuthMiddleware()]
    ),
  ];
}
