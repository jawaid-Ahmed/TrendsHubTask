import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:trends_hub/constants/constants.dart';
import 'package:trends_hub/routes/routes.dart';
import 'package:trends_hub/services/data_parser.dart';

class SignupControlller extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController cPassController = TextEditingController();

  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  @override
  void onInit() {
    super.onInit();
  }

  createUserInFirebase(String email, String pass) async {
    try {
      EasyLoading.show(status: 'Creating Account...');

      var val = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: pass,
      );

      if (val.user != null) {
        await addUser();
      }
    } on FirebaseAuthException catch (e) {
      EasyLoading.dismiss();
      Get.snackbar('Something went wrong',
          "follow correct email formate and min password length is 6 letters");
    }
  }

  createUser() async {
    if (emailController.text.isNotEmpty && passController.text.isNotEmpty) {
      //login in here
      if (passController.text.toString().trim() ==
          cPassController.text.toString().trim()) {
        await createUserInFirebase(emailController.text.toString().trim(),
            passController.text.toString().trim());
      } else {
        Get.snackbar("Password Missmatch",
            "Password and confirm passwrods does not match");
      }
    } else {
      Get.snackbar("Empty Fields", "All the fields are required for register");
    }
  }

  addUser() {
    EasyLoading.show();

    Map<String, dynamic> userMap = {
      "userId": DateTime.now().microsecondsSinceEpoch.toString(),
      "username": usernameController.text.toString(),
      "email": emailController.text.toString(),
      "isActive": true,
      "isSocial": dataParser.getBool(false),
      "createdDate": dataParser.getString(DateTime.now().toString()),
      "profileUrl": "",
    };

    CollectionReference collection =
        _fireStore.collection(constants.usersCollection);

    print("hello");

    DocumentReference users = collection.doc(emailController.text.toString());

    print("hello2");
    print(userMap);

    users.set(userMap).then((value) {
      Get.snackbar("Account Created", "Login now with your account");
      EasyLoading.dismiss();

      Get.offAndToNamed(AppRoutes.loginRoute);
    }).catchError((error) {
      print(error);
      EasyLoading.showError("Registration Failed",
          dismissOnTap: true, duration: const Duration(seconds: 2));
    });
  }
}
