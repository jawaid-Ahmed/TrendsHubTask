import 'package:get/get.dart';
import 'package:trends_hub/constants/constants.dart';
import 'package:trends_hub/services/datastoreservice.dart';

AuthService authService = AuthService();

class AuthService extends GetxController {
  bool isLoggedIn() {
    return dataStore.getBool(constants.isLoggedIn);
  }
}
