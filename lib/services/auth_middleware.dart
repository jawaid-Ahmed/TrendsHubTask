import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trends_hub/routes/routes.dart';
import 'package:trends_hub/services/auth_service.dart';

class AuthMiddleware extends GetMiddleware {
  final authService = Get.find<AuthService>();
  @override
  int? get priority => 1;
  bool isAuthenticated = false;

  @override
  RouteSettings? redirect(String? route) {
    isAuthenticated = authService.isLoggedIn();
    if (isAuthenticated == false) {
      return RouteSettings(name: AppRoutes.loginRoute);
    }
    return null;
  }
}
