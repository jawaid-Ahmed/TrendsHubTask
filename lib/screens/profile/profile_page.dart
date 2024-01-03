import 'dart:io';

// import 'package:cached_network_image/cached_network_image.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trends_hub/constants/my_theme.dart';
import 'package:trends_hub/routes/routes.dart';
import 'package:trends_hub/screens/profile/profile_controller.dart';
import 'package:trends_hub/widgets/custom_button.dart';
import 'package:trends_hub/widgets/custom_textview.dart';

class ProfilePage extends GetView<ProfileController> {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: SafeArea(
          child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          SizedBox(
            height: 200,
            child: Center(
              child: Stack(
                children: [
                  Obx(() => controller.filePath.value.isNotEmpty
                      ? CircleAvatar(
                          radius: 80,
                          backgroundColor: Colors.grey.shade200,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(80),
                            child: Image.file(
                              File(controller.filePath.value),
                              fit: BoxFit.cover,
                            ),
                          ))
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: CachedNetworkImage(
                              errorWidget: (context, url, error) =>
                                  CircleAvatar(
                                    radius: 80,
                                    backgroundColor: Colors.grey.shade100,
                                  ),
                              imageUrl: controller.currentUser.value.profileUrl,
                              placeholder: (context, url) {
                                return CircleAvatar(
                                  radius: 80,
                                  backgroundImage: const AssetImage(
                                    "assets/images/1.png",
                                  ),
                                  backgroundColor: Colors.grey.shade200,
                                );
                              }),
                        )),
                  Positioned(
                      bottom: 5,
                      right: 5,
                      child: IconButton(
                        icon: const Icon(
                          Icons.photo_camera,
                          size: 35,
                          color: Colors.black,
                        ),
                        onPressed: () {
                          //upload picture button here

                          controller.uploadImage();
                        },
                      ))
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(22),
                color: Theme.of(context).scaffoldBackgroundColor,
              ),
              padding:
                  const EdgeInsets.symmetric(horizontal: 12.0, vertical: 15),
              child: SingleChildScrollView(
                child: Column(children: [
                  CustomTextView(
                    text: controller.currentUser.value.username,
                    fontWeight: FontWeight.bold,
                    textSize: 18,
                  ),
                  CustomTextView(
                    text: controller.currentUser.value.email,
                    fontWeight: FontWeight.bold,
                    textSize: 16,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomButton(
                    text: "Logout",
                    onPressed: () {
                      controller.logout();
                    },
                    bgColor: MyThemes.primaryColor,
                    width: size.width,
                    iconColor: Colors.white,
                    textColor: Colors.white,
                    radius: 15,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomButton(
                    text: "Setup Address",
                    onPressed: () async {
                      controller.lastAddress.value =
                          await Get.toNamed(AppRoutes.addressPage) as String;
                    },
                    bgColor: MyThemes.primaryColor,
                    width: size.width,
                    iconColor: Colors.white,
                    textColor: Colors.white,
                    radius: 15,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  getDeleteButton(context, size),
                  const SizedBox(
                    height: 20,
                  ),
                ]),
              ),
            ),
          ),
          Obx(
            () => CustomButton(
              text: "Update Profile",
              enabled: controller.imageChanged.value,
              onPressed: () {
                controller.saveChangesData();
              },
              bgColor: MyThemes.primaryColor,
              width: size.width,
              iconColor: Colors.white,
              textColor: Colors.white,
              radius: 15,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
        ]),
      )),
    );
  }

  Widget getDeleteButton(BuildContext context, Size size) {
    return GestureDetector(
      onTap: () {
        accountDeleteSheet(context, size);
      },
      child: Container(
        width: size.width,
        margin: const EdgeInsets.symmetric(horizontal: 12),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Theme.of(context).canvasColor,
        ),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextView(
                text: "Account Deletion",
                textSize: 18,
                fontWeight: FontWeight.normal,
              ),
              const SizedBox(
                height: 5,
              ),
              CustomTextView(
                text: controller.currentUser.value.email,
                textSize: 14,
              ),
              const SizedBox(
                height: 5,
              ),
              CustomTextView(
                text: "Delete your account",
                textSize: 18,
                fontWeight: FontWeight.normal,
                textColor: MyThemes.primaryColor,
              ),
            ]),
      ),
    );
  }

  void accountDeleteSheet(BuildContext context, Size size) {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return deleteAccountWidget(context, size);
      },
    );
  }

  Widget deleteAccountWidget(context, size) {
    return Container(
      height: 250,
      decoration: BoxDecoration(
          color: Theme.of(context).canvasColor,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(15), topRight: Radius.circular(15))),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            CustomTextView(
              text: "Account Deletion",
              fontWeight: FontWeight.bold,
              textSize: 18,
              textColor: Theme.of(context).cardColor,
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: CustomTextView(
                text: "Delete your account permanantly",
                fontWeight: FontWeight.normal,
                textSize: 12,
                textColor: Theme.of(context).cardColor,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomButton(
                  text: "Delete",
                  onPressed: () {
                    // controller.deleteAccount();
                  },
                  bgColor: MyThemes.primaryColor,
                  width: size.width * 0.4,
                  textColor: Colors.white,
                  radius: 15,
                ),
                CustomButton(
                  text: "Cancel",
                  textColor: Colors.white,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  width: size.width * 0.4,
                  iconColor: Theme.of(context).cardColor,
                  radius: 15,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
