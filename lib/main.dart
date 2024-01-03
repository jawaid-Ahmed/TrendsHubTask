import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:trends_hub/constants/constants.dart';
import 'package:trends_hub/constants/my_theme.dart';
import 'package:trends_hub/routes/routes.dart';
import 'package:trends_hub/screens/login/login_binding.dart';
import 'package:trends_hub/services/auth_service.dart';
import 'package:trends_hub/services/data_parser.dart';
import 'package:trends_hub/services/datastoreservice.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  await GetStorage.init();
  Get.put(AuthService());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: constants.AppTitle,
      builder: EasyLoading.init(),
      initialBinding: LoginBindings(),
      debugShowCheckedModeBanner: false,
      theme: MyThemes.lightTheme,
      darkTheme: MyThemes.darkTheme,
      themeMode: ThemeMode.light,
      initialRoute: AppRoutes.homePage,
      getPages: AppRoutes.routes,
    );
  }

  getInitialPage() {
    var isLog = dataStore.getBool(constants.isLoggedIn);
    print('.............main...........');

    print(isLog);

    return isLog ? AppRoutes.homePage : AppRoutes.loginRoute;
  }
}

showBar(dynamic title, dynamic message, {ToastType? type}) {
  Get.snackbar(dataParser.getCapitalizeFirst(title),
      dataParser.getCapitalizeFirst(message),
      snackPosition: SnackPosition.TOP,
      backgroundColor: getColor(type),
      colorText: Colors.white);
}

showError(String val) {
  EasyLoading.showError(val,
      dismissOnTap: true, duration: const Duration(seconds: 2));
}

Color getColor(ToastType? type) {
  if (type == null) {
    return Colors.black;
  }

  return type == ToastType.ERROR
      ? Colors.red
      : type == ToastType.FAILED
          ? Colors.black
          : Colors.green;
}

enum ToastType { SUCCESS, FAILED, ERROR }
