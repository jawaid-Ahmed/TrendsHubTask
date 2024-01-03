import 'package:get/get.dart';
import 'package:trends_hub/screens/camerapage/camera_controller.dart';
import 'package:trends_hub/screens/homepage/dashboard_controller.dart';
import 'package:trends_hub/screens/imagespage/images_controller.dart';
import 'package:trends_hub/screens/profile/profile_controller.dart';

class RootBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<DashboardController>(DashboardController());
    Get.put<ProfileController>(ProfileController());
    Get.put<CameraController>(CameraController());
    Get.put<ImagesController>(ImagesController());
    // Get.put<AddressController>(AddressController());
  }
}
