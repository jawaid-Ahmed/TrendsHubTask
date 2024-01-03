import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:trends_hub/constants/my_theme.dart';
import 'package:trends_hub/routes/routes.dart';
import 'package:trends_hub/screens/signup/signup_controller.dart';
import 'package:trends_hub/widgets/textfield_widget.dart';

class SignupPage extends GetView<SignupControlller> {
  const SignupPage({super.key});

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
                IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      color: Colors.black,
                    )),
                const SizedBox(
                  height: 140,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(
                    'assets/icons/logo.png',
                    width: 140,
                    height: 140,
                  ),
                ),
                const SizedBox(
                  height: 50,
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
                      controller: controller.usernameController,
                      hintText: 'Username',
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
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomTextField(
                      controller: controller.cPassController,
                      hintText: 'Confirm Password',
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
                    controller.createUser();
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
                          "Register",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      )),
                ),
                const SizedBox(
                  height: 60,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Already have an account? ",
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: MyThemes.textColor),
                    ),
                    GestureDetector(
                        onTap: () {
                          Get.toNamed(AppRoutes.loginRoute);
                        },
                        child: Text(
                          "Login ",
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
}
