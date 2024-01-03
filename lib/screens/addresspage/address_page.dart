import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:trends_hub/constants/constants.dart';
import 'package:trends_hub/constants/my_theme.dart';
import 'package:trends_hub/main.dart';
import 'package:trends_hub/services/data_parser.dart';
import 'package:trends_hub/services/datastoreservice.dart';
import 'package:trends_hub/widgets/textfield_widget.dart';

import '../../widgets/custom_textview.dart';
import 'package:http/http.dart' as http;

class AddressPage extends StatelessWidget {
  const AddressPage({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    AddressController controller = Get.put(AddressController());
    return SafeArea(
        child: Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
                height: size.height * 0.5, child: getMap(context, controller)),
            const SizedBox(
              height: 15,
            ),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 12.0),
            //   child: Obx(
            //     () => CustomTextView(
            //       maxLines: 2,
            //       text: controller.address.value,
            //       fontWeight: FontWeight.normal,
            //       textSize: 12,
            //     ),
            //   ),
            // ),
            // const SizedBox(
            //   height: 5,
            // ),
            Obx(
              () => CustomTextField(
                  controller: TextEditingController(
                      text: controller.address.value.isNotEmpty
                          ? controller.address.value
                          : controller.addressController),
                  hintText: 'Email',
                  hintColor: Theme.of(context).cardColor,
                  // prefixIcon: Icons.email,
                  onChange: (val) {
                    controller.addressController = val;
                  }),
            ),
            const SizedBox(
              height: 5,
            ),
            CustomTextField(
                hintText: "Appartment/house  no. & Street No",
                controller: TextEditingController(
                    text: controller.street.value.isNotEmpty
                        ? controller.street.value
                        : controller.streetController),
                onChange: (val) {
                  controller.streetController = val;
                  // controller.street.value = val;
                }),
            const SizedBox(
              height: 5,
            ),
            Obx(
              () => CustomTextField(
                  hintText: "Building name",
                  controller: TextEditingController(
                      text: controller.building.value.isNotEmpty
                          ? controller.building.value
                          : controller.buildingController),
                  onChange: (val) {
                    controller.buildingController = val;
                    // controller.building.value = val;
                  }),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
          backgroundColor: MyThemes.primaryColor,
          label: Obx(
            () => Row(
              children: [
                if (controller.addressLoading.value) ...[
                  const SizedBox(
                    height: 22,
                    width: 22,
                    child: CircularProgressIndicator.adaptive(),
                  ),
                ],
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: CustomTextView(
                    maxLines: 1,
                    textColor: Colors.white,
                    text: "Save Address",
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          onPressed: () {
            if (controller.buildingController.isNotEmpty) {
              if (controller.streetController.isNotEmpty) {
                controller.saveAddress();
              } else {
                showBar('Appartment No', 'Appartment no is required');
              }
            } else {
              showBar('Building Name', 'Building name is required');
            }
          }),
    ));
  }

  Widget getMap(BuildContext context, AddressController controller) {
    return Obx(
      () => GoogleMap(
        myLocationButtonEnabled: controller.locationPermissionEnabled.value,
        myLocationEnabled: true,
        buildingsEnabled: true,
        mapType: MapType.hybrid,
        initialCameraPosition: CameraPosition(
            bearing: 192.8334901395799,
            target: controller.latlong.value,
            tilt: 59.440717697143555,
            zoom: 19.151926040649414),
        onMapCreated: (GoogleMapController ctr) {
          controller.mapController.complete(ctr);
        },
        onTap: (latlng) async {
          controller.latlong.value = latlng;
          await controller.getAddress(latlng);
        },
        markers: {
          Marker(
              markerId: const MarkerId("Sydney"),
              position: controller.latlong.value),
        },
      ),
    );
  }
}

class AddressController extends GetxController {
  RxString address = RxString("");
  RxString building = RxString("");
  RxString city = RxString("");
  String addressController = "";
  String buildingController = "";
  String streetController = "";
  RxString street = RxString("");
  final Completer<GoogleMapController> mapController =
      Completer<GoogleMapController>();

  RxBool locationPermissionEnabled = false.obs;

  RxBool addressLoading = false.obs;

  Rx<LatLng> latlong = const LatLng(25.2048, 55.2708).obs;

  @override
  void onInit() {
    getLocationPermission();

    super.onInit();
  }

  getAddressFromLatLng(double lat, double lng) async {
    String _host = 'https://maps.google.com/maps/api/geocode/json';
    final url =
        '$_host?key=AIzaSyAi1kchiCArU7FF3f2TrSKfmzrmmoHk-Eg&language=en&latlng=$lat,$lng';
    if (lat != null && lng != null) {
      pf('address from latlong');
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        pf('address success');
        Map data = jsonDecode(response.body);
        String _formattedAddress = data["results"][0]["formatted_address"];
        print("response ==== $_formattedAddress");
        return _formattedAddress;
      } else {
        print(response.body);
        return null;
      }
    } else
      return null;
  }

  getMyLocation() async {
    address.value =
        dataParser.getString(dataStore.getString(constants.addressKey));
    buildingController =
        dataParser.getString(dataStore.getString(constants.buidingNameKey));
    streetController =
        dataParser.getString(dataStore.getString(constants.appartmentNo));

    if (address.value == null ||
        address.value.isEmpty ||
        address.value.toString() == "null") {
      Position position = await getCurrentLocation();
      latlong.value = LatLng(position.latitude, position.longitude);
      getAddressFromLatLng(position.latitude, position.longitude);
      // getAddressFromCoordinates(
      //     latlong.value.latitude, latlong.value.longitude);
      // update();
    } else {}

    locationPermissionEnabled.value = true;
  }

  String generateGoogleMapsUrlFromLatLng(double latitude, double longitude) {
    return 'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
  }

  saveAddress() async {
    if (address.isNotEmpty) {
      String url = await generateGoogleMapsUrlFromLatLng(
          latlong.value.latitude, latlong.value.longitude);

      String fulladdress =
          "$streetController $buildingController ${address.value}";

      await dataStore.setString(constants.addressKey, address.value);
      await dataStore.setString(constants.addressUrl, url);
      await dataStore.setString(constants.buidingNameKey, buildingController);
      await dataStore.setString(constants.appartmentNo, streetController);

      address.value = fulladdress;

      Get.back(result: address.value);
    } else {
      showBar(
          'Save Failed', 'Please Provide address or select location in map');
    }
  }

  Future<void> getAddressCoordinates(String address) async {
    try {
      List<Location> locations = await locationFromAddress(address);
      if (locations.isNotEmpty) {
        print("Latitude: ${locations[0].latitude}");
        print("Longitude: ${locations[0].longitude}");
      } else {
        print("No location found for the address.");
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  Future<void> getAddress(LatLng ll) async {
    addressLoading.value = true;
    address.value = await getAddressFromCoordinates(
      ll.latitude,
      ll.longitude,
    );

    addressLoading.value = false;
  }

  Future<void> getLocationPermission() async {
    pf("locationpermission");
    final locationPermission = await Geolocator.checkPermission();
    if (locationPermission == LocationPermission.denied) {
      final permissionRequest = await Geolocator.requestPermission();
      if (permissionRequest != LocationPermission.whileInUse ||
          permissionRequest != LocationPermission.always) {
        locationPermissionEnabled.value = true;

        getMyLocation();
        showBar("Location Permission",
            "Please allow location permission for you address verification");
        await Geolocator.requestPermission();
        return;
      }
    } else {
      getMyLocation();
    }
  }

  Future<Position> getCurrentLocation() async {
    pf("getCurrentLocation");

    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }

  // Future<String> getAddressFromCoordinates(
  //     double latitude, double longitude) async {
  //   final placemarks = await placemarkFromCoordinates(latitude, longitude);

  //   if (placemarks.isNotEmpty) {
  //     final placemark = placemarks[0];

  //     final address =
  //         '${placemark.street}, ${placemark.subLocality}, ${placemark.locality}, ${placemark.postalCode}, ${placemark.country}';

  //     city.value = placemark.locality.toString();

  //     return address;
  //   } else {
  //     return stringConstants.addressNotFound.tr;
  //   }
  // }

  Future<String> getAddressFromCoordinates(
      double latitude, double longitude) async {
    const maxRetries = 3; // Maximum number of retries
    int retryCount = 0;
    pf("getAddressfromCoordinates");

    while (retryCount < maxRetries) {
      try {
        pf("placemarks .>.");

        final placemarks = await placemarkFromCoordinates(latitude, longitude);

        pf("placemarks");
        print(latitude);
        print(longitude);

        if (placemarks.isNotEmpty) {
          final placemark = placemarks[0];

          final addrss =
              '${placemark.street}, ${placemark.subLocality}, ${placemark.locality}, ${placemark.postalCode}, ${placemark.country}';

          city.value = placemark.locality.toString();
          pf(city.value);

          address.value = addrss;
          pf("address");
          print(address.value);

          return addrss;
        } else {
          return "Address not found";
        }
      } catch (e) {
        print('Error getting placemarks: $e');
        retryCount++;
        if (retryCount < maxRetries) {
          // Implement exponential backoff or wait for a while before retrying.
          // You can use a package like 'retry' to handle retries more elegantly.
          await Future.delayed(Duration(seconds: 1 << retryCount));
        } else {
          // If all retries fail, return an error message.
          return 'Failed to retrieve address';
        }
      }
    }

    // If all retries fail, return an error message.
    return 'Failed to retrieve address';
  }

  Future<List<Placemark>> getPlacemarksFromPosition(Position position) async {
    final placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    return placemarks;
  }
}

pf(dynamic v) {
  print("...........................${v.toString()}......................");
}
