import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trends_hub/constants/my_theme.dart';
import 'package:trends_hub/models/image.dart';
import 'package:trends_hub/screens/camerapage/camera_page.dart';
import 'package:trends_hub/screens/imagespage/images_page.dart';
import 'package:trends_hub/screens/profile/profile_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  List<Widget> homePages = [
    const ImagesPage(),
    const CameraPage(),
    const ProfilePage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 40,
              ),
              Expanded(child: homePages[_selectedIndex])
            ],
          ),
        ),
        bottomNavigationBar: getBottomNav(context));
  }

  getBottomNav(BuildContext context) {
    return BottomNavigationBar(
        currentIndex: _selectedIndex,
        showUnselectedLabels: false,
        unselectedItemColor: Theme.of(context).cardColor,
        selectedItemColor: MyThemes.primaryColor,
        selectedIconTheme: IconThemeData(
          color: MyThemes.primaryColor,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: TextStyle(
          color: MyThemes.primaryColor,
        ),
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
              ),
              label: "HomePage",
              backgroundColor: Colors.transparent),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.camera,
              ),
              label: "Camera",
              backgroundColor: Colors.transparent),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
              ),
              label: "Profile",
              backgroundColor: Colors.transparent),
        ]);
  }
}
