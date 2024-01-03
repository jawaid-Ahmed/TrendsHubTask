import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trends_hub/screens/camerapage/camera_controller.dart';
import 'package:trends_hub/widgets/custom_button.dart';
import 'package:trends_hub/widgets/custom_textview.dart';

class CameraPage extends GetView<CameraController> {
  const CameraPage({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () {
                  controller.selectImageFromCamera();
                },
                child: Container(
                    width: size.width * 0.35,
                    height: 55,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.black,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Icon(
                          Icons.camera,
                          size: 45,
                          color: Colors.white,
                        ),
                        CustomTextView(
                          text: "Camera",
                          textColor: Colors.white,
                          textSize: 18,
                          fontWeight: FontWeight.bold,
                        )
                      ],
                    )),
              ),
              GestureDetector(
                onTap: () {
                  controller.selectImageFromGallery();
                },
                child: Container(
                    width: size.width * 0.35,
                    height: 55,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.black,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Icon(
                          Icons.browse_gallery,
                          size: 45,
                          color: Colors.white,
                        ),
                        CustomTextView(
                          text: "Gallary",
                          textColor: Colors.white,
                          textSize: 18,
                          fontWeight: FontWeight.bold,
                        )
                      ],
                    )),
              ),
            ],
          ),
          Expanded(
              child: Container(
            width: size.width,
            margin: const EdgeInsets.all(12),
            child: Obx(
              () => ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: controller.filePath.value.isEmpty
                    ? Image.asset(
                        "assets/images/1.png",
                        fit: BoxFit.cover,
                      )
                    : Image.file(
                        File(controller.filePath.value),
                        fit: BoxFit.cover,
                      ),
              ),
            ),
          )),
          Obx(
            () => CustomButton(
              text: controller.imageSelected.value
                  ? "Upload Image"
                  : "Select Image",
              onPressed: () {
                controller.uploadImage();
              },
              radius: 12,
              width: size.width,
              enabled: controller.imageSelected.value,
            ),
          )
        ],
      ),
    );
  }
}
