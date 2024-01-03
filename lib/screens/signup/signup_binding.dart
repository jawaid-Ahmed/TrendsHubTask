import 'package:get/get.dart';
import 'package:trends_hub/screens/signup/signup_controller.dart';

class SignupBindings implements Bindings {
  @override
  void dependencies() {
    Get.put<SignupControlller>(SignupControlller());
  }
}
