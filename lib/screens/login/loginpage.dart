import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trends_hub/constants/my_theme.dart';
import 'package:trends_hub/routes/routes.dart';
import 'package:trends_hub/screens/login/login_controller.dart';
import 'package:trends_hub/widgets/textfield_widget.dart';

class LoginPage extends GetView<LoginController> {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 40,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(
                    'assets/icons/logo.png',
                    width: size.width * 0.4,
                    height: 250,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomTextField(
                      controller: controller.emailController,
                      hintText: 'Email',
                      hintColor: Theme.of(context).cardColor,
                      // prefixIcon: Icons.email,
                      onChange: (val) {}),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomTextField(
                      controller: controller.passController,
                      hintText: 'Password',
                      suffixIcon: const Icon(
                        Icons.visibility,
                        color: MyThemes.iconColor,
                      ),
                      hintColor: Theme.of(context).cardColor,
                      // prefixIcon: Icons.email,
                      onChange: (val) {}),
                ),
                GestureDetector(
                  onTap: () {
                    controller.login();
                  },
                  child: Container(
                      width: size.width * 0.9,
                      height: 60,
                      margin: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: MyThemes.buttonColor,
                        border:
                            Border.all(width: 1, color: MyThemes.shimmerCollor),
                      ),
                      child: const Center(
                        child: Text(
                          "Login",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      )),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                        onTap: () {},
                        child: SocialButton(
                            size, 'assets/icons/apple.png', "Apple")),
                    GestureDetector(
                        onTap: () {
                          controller.signInWithGoogle();
                        },
                        child: SocialButton(
                            size, 'assets/icons/google.png', "Google"))
                  ],
                ),
                const SizedBox(
                  height: 60,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Don't have an account? ",
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: MyThemes.textColor),
                    ),
                    GestureDetector(
                        onTap: () {
                          Get.toNamed(AppRoutes.signUpRoute);
                        },
                        child: Text(
                          "Register ",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: MyThemes.primaryColor),
                        ))
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget SocialButton(Size size, String image, String name) {
    return Container(
      width: size.width * 0.4,
      height: 70,
      margin: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(width: 1, color: MyThemes.shimmerCollor),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.asset(
            image,
            width: 55,
            height: 55,
            fit: BoxFit.cover,
          ),
          Text(
            name,
            style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}
