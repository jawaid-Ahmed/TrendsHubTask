import 'package:get/get.dart';
import 'package:trends_hub/screens/login/login_controller.dart';

class LoginBindings implements Bindings {
  @override
  void dependencies() {
    Get.put<LoginController>(LoginController());
  }
}
