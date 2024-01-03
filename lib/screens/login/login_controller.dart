import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:trends_hub/constants/constants.dart';
import 'package:trends_hub/models/user.dart';
import 'package:trends_hub/routes/routes.dart';
import 'package:trends_hub/services/data_parser.dart';
import 'package:trends_hub/services/datastoreservice.dart';

class LoginController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  @override
  void onInit() {
    super.onInit();
  }

  Future<void> login() async {
    if (emailController.text.isNotEmpty && passController.text.isNotEmpty) {
      //login in here
      await loginUserEmailAndPass(emailController.text.toString().trim(),
          passController.text.toString().trim());
    } else {
      Get.snackbar("Empty Fields", "Email and password are required for login");
    }
  }

  loginUserEmailAndPass(String email, String pass) async {
    try {
      EasyLoading.show(status: 'Loging In...');
      var val = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: pass,
      );

      if (val.user != null) {
        getUserAndLogin(email, pass);
      }
    } on FirebaseAuthException catch (e) {
      EasyLoading.dismiss();
      if (e.code == 'user-not-found') {
        Get.snackbar('User not found', "Please create an account first");
      } else if (e.code == 'wrong-password') {
        Get.snackbar('Wrong password', "Please provide correct password");
      } else {
        Get.snackbar('Invalid Credentials', "Invalid email or password");
      }
    }
  }

  getUserAndLogin(String email, String pass) async {
    DocumentReference userRef =
        _fireStore.collection(constants.usersCollection).doc(email);

    var data = await userRef.get();
    RegisterUser user =
        RegisterUser.fromMap(data.data() as Map<String, dynamic>);

    if (user.email.isNotEmpty) {
      await dataStore.setBool(constants.isLoggedIn, true);
      await dataStore.setMap(constants.userKey, user.toMap());
      EasyLoading.dismiss();

      print('.............login...........');
      var hello = await dataStore.getBool(constants.isLoggedIn);
      print(hello);

      Get.offAndToNamed(AppRoutes.homePage);
    }
  }

  Future<void> signInWithGoogle() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    if (googleUser != null && googleUser.email.isNotEmpty) {
      EasyLoading.show(dismissOnTap: true, status: 'Loging you in...');

      AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth!.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in to Firebase with the Google Auth credentials
      final UserCredential authResult =
          await _auth.signInWithCredential(credential);

      print(googleUser.email);
      print(googleUser.displayName);

      if (authResult.user != null) {
        await addUser(googleUser.displayName.toString(), googleUser.email,
            googleUser.photoUrl.toString());
      }
    }
  }

  addUser(String username, String email, String profileUrl) {
    EasyLoading.show();

    if (email.isEmpty) {
      return;
    }

    Map<String, dynamic> userMap = {
      "userId": email,
      "username": username,
      "email": email,
      "isActive": true,
      "isSocial": dataParser.getBool(true),
      "createdDate": dataParser.getString(DateTime.now().toString()),
      "profileUrl": profileUrl,
    };

    CollectionReference collection =
        _fireStore.collection(constants.usersCollection);
    DocumentReference users = collection.doc(email);

    users.set(userMap).then((value) async {
      Get.snackbar("Account Created", "Login now with your account");
      EasyLoading.dismiss();
      await dataStore.setBool(constants.isLoggedIn, true);
      await dataStore.setMap(constants.userKey, userMap);

      Get.offAndToNamed(AppRoutes.homePage);
    }).catchError((error) {
      EasyLoading.showError("Registration Failed",
          dismissOnTap: true, duration: const Duration(seconds: 2));
    });
  }
}
