import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
// import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:trends_hub/constants/constants.dart';
import 'package:trends_hub/main.dart';
import 'package:trends_hub/models/user.dart';
import 'package:trends_hub/routes/routes.dart';
import 'package:trends_hub/services/auth_service.dart';
import 'package:trends_hub/services/datastoreservice.dart';

class ProfileController extends GetxController {
  RxString lastAddress = RxString("");

  @override
  void onInit() {
    getUser();
    super.onInit();
  }

  getUser() async {
    var userMap = await dataStore.getMap(constants.userKey);
    currentUser.value = RegisterUser.fromMap(userMap);

    if (currentUser.value.email.isEmpty) {
      Get.offAllNamed(AppRoutes.loginRoute);
    }
  }

  RxString filePath = RxString("");
  RxBool imageChanged = RxBool(false);

  Rx<RegisterUser> currentUser = Rx<RegisterUser>(RegisterUser.fromMap({}));

  final storage = FirebaseStorage.instance;
  final _firestore = FirebaseFirestore.instance;

  String getFullName() {
    return currentUser.value.username;
  }

  uploadImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.image,
    );

    if (result != null) {
      File file = File(result.files.single.path!);
      currentUser.value.profileUrl = "";
      filePath.value = file.path;
      imageChanged.value = true;
    } else {
      showBar("Image Selection", "No Image Selected");
    }
  }

  saveChangesData() async {
    EasyLoading.show(status: "Updating Profile...", dismissOnTap: true);
    if (filePath.value.isNotEmpty) {
      EasyLoading.show(status: "Uploading Image...", dismissOnTap: true);
      File file = File(filePath.value);
      String downloadUrl = await uploadTaskToFirebaseStorage(
          file, constants.profilesStoragePath, currentUser.value.email);

      if (downloadUrl.isNotEmpty) {
        currentUser.value.profileUrl = downloadUrl;

        EasyLoading.show(status: "Updating Changes...", dismissOnTap: true);

        await _firestore
            .collection(constants.usersCollection)
            .doc(currentUser.value.email)
            .set(currentUser.value.toMap())
            .then((value) {
          dataStore.setMap(constants.userKey, currentUser.value.toMap());
          EasyLoading.showSuccess("Profile Updated Successfully");
          imageChanged.value = false;
        });
      } else {
        showBar("Profile Image", "Image Uploaded Failed");
        EasyLoading.dismiss();
      }
    } else {
      await _firestore
          .collection(constants.usersCollection)
          .doc(currentUser.value.email)
          .set(currentUser.value.toMap())
          .then((value) {
        dataStore.setMap(constants.userKey, currentUser.value.toMap());
        EasyLoading.showSuccess("Profile Updated Successfully");
      });
    }
  }

  Future<String> uploadTaskToFirebaseStorage(
      File taskFile, String path, String fileName) async {
    try {
      Reference storageReference = storage.ref().child(path).child(fileName);

      bool fileExists = await storageReference
          .getDownloadURL()
          .then((value) => true)
          .catchError((error) => false);
      if (fileExists) {
        await storageReference.delete();
      }
      UploadTask uploadTask = storageReference.putFile(taskFile);
      TaskSnapshot taskSnapshot = await uploadTask;

      String downloadUrl = await taskSnapshot.ref.getDownloadURL();

      return downloadUrl;
    } catch (e) {
      print('Error uploading task: $e');
      return "";
    }
  }

  deleteAccount() async {
    EasyLoading.showInfo("Deleting Account..");
    DocumentReference docRef = _firestore
        .collection(constants.usersCollection)
        .doc(currentUser.value.email);
    await docRef.delete().then((value) {
      dataStore.setMap(constants.userKey, {});
      dataStore.setBool(constants.isLoggedIn, false);
      FirebaseAuth.instance.signOut();
      EasyLoading.showSuccess("Account Deleted Successfully");
      Get.offAndToNamed(AppRoutes.loginRoute);
    });
  }

  logout() async {
    EasyLoading.showInfo("Loging out..", dismissOnTap: true);
    dataStore.setMap(constants.userKey, {});
    dataStore.setBool(constants.isLoggedIn, false);
    FirebaseAuth.instance.signOut();
    EasyLoading.dismiss();
    Get.offAndToNamed(AppRoutes.loginRoute);
  }
}
