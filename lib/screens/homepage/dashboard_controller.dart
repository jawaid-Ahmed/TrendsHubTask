import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class DashboardController extends GetxController {
  @override
  void onInit() {
    EasyLoading.dismiss();
    super.onInit();
  }
}
