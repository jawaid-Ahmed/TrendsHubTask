import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:trends_hub/constants/constants.dart';
import 'package:trends_hub/main.dart';
import 'package:trends_hub/models/image.dart';
import 'package:trends_hub/models/user.dart';
import 'package:trends_hub/routes/routes.dart';
import 'package:trends_hub/screens/addresspage/address_page.dart';
import 'package:trends_hub/services/datastoreservice.dart';

class CameraController extends GetxController {
  RxBool imageSelected = RxBool(false);
  RxString filePath = RxString("");
  Rx<RegisterUser> currentUser = Rx<RegisterUser>(RegisterUser.fromMap({}));

  final storage = FirebaseStorage.instance;
  final _firestore = FirebaseFirestore.instance;

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

  selectImageFromGallery() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.image,
    );

    if (result != null) {
      File file = File(result.files.single.path!);
      currentUser.value.profileUrl = "";
      filePath.value = file.path;
      imageSelected.value = true;
    } else {
      showBar("Image Selection", "No Image Selected");
    }
  }

  selectImageFromCamera() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      File file = File(pickedFile.path);
      currentUser.value.profileUrl = "";
      filePath.value = file.path;
      imageSelected.value = true;
    } else {
      showBar("Image Selection", "No Image Selected");
    }
  }

  Future<String> uploadTaskToFirebaseStorage(
      File taskFile, String path, String fileName) async {
    try {
      Reference storageReference =
          storage.ref().child(constants.imagesStoragePath).child(fileName);

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

  uploadImage() async {
    if (filePath.value.isEmpty) {
      showBar("File not selected", "Please select file first to upload");
      return;
    }
    EasyLoading.show(status: "Uploading Image...");

    try {
      File nFile = File(filePath.value);
      String fileName = DateTime.now().microsecondsSinceEpoch.toString();

      String url =
          await uploadTaskToFirebaseStorage(nFile, filePath.value, fileName);

      ImageModel image = ImageModel(
          fileName: fileName,
          userId: filePath.value,
          fileUrl: url,
          createdDate: DateTime.now().toString());

      await _firestore
          .collection(constants.imagesCollection)
          .doc(fileName)
          .set(image.toMap())
          .then((value) => {
                filePath.value = "",
                imageSelected.value = false,
                EasyLoading.showSuccess("Image Uploaded Successfully")
              });
    } catch (e) {
    } finally {
      EasyLoading.dismiss();
    }
  }
}
