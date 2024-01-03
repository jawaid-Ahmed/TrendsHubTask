import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:trends_hub/models/image.dart';
import 'package:trends_hub/screens/imagespage/images_controller.dart';

class ImagesPage extends GetView<ImagesController> {
  const ImagesPage({super.key});

  @override
  Widget build(BuildContext context) {
    ImagesController ctr = Get.find<ImagesController>();
    ctr.onInit();
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "Trends Hub",
              style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
          ),
          Expanded(
            child: Obx(
              () => MasonryGridView.builder(
                physics: const BouncingScrollPhysics(),
                gridDelegate:
                    const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2),
                itemCount: controller.imagesList.length,
                itemBuilder: (context, index) {
                  ImageModel item = controller.imagesList[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: CachedNetworkImage(
                          // progressIndicatorBuilder: (context, url, progress) {
                          //   return CircularProgressIndicator()
                          // },
                          imageUrl: item.fileUrl,
                          placeholder: (context, url) {
                            return Image.asset(
                              "assets/images/1.png",
                              height: 300,
                              fit: BoxFit.cover,
                            );
                          },
                          errorWidget: (context, obj, st) {
                            return Image.asset(
                              "assets/images/1.png",
                              height: 300,
                              fit: BoxFit.cover,
                            );
                          },
                        )),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
