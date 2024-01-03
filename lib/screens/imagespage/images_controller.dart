import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:trends_hub/constants/constants.dart';
import 'package:trends_hub/models/image.dart';
import 'package:trends_hub/screens/addresspage/address_page.dart';

class ImagesController extends GetxController {
  RxList<ImageModel> imagesList = RxList();

  @override
  void onInit() {
    loadImages();
    pf('onInitimagesController');
    super.onInit();
  }

  loadImages() async {
    try {
      imagesList.clear();
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection(constants.imagesCollection)
          // .where('washerId',
          //     isEqualTo: washer.value.phone.isNotEmpty ? washer.value.phone : "NoUser")

          .get();

      List<QueryDocumentSnapshot> images = querySnapshot.docs;

      for (QueryDocumentSnapshot image in images) {
        ImageModel imageModel =
            ImageModel.fromMap(image.data() as Map<String, dynamic>);

        imagesList.add(imageModel);
      }
    } catch (e) {
      print("Error retrieving transactions: $e");
    }
  }
}
