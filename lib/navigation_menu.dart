import 'package:aiapparel/features/pages/home/home.dart';
import 'package:aiapparel/features/pages/settings/settings.dart';
import 'package:aiapparel/features/pages/wardrobe/wardrobe.dart';
import 'package:aiapparel/utils/constants/colors.dart';
import 'package:aiapparel/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'features/pages/favourites/favourites.dart';

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());
    final darkMode = AHelperFunctions.isDarkMode(context);

    return Scaffold(
      bottomNavigationBar: Obx(
        () => NavigationBar(
          height: 80,
          elevation: 0,
          selectedIndex: controller.selectIndex.value,
          onDestinationSelected: (index) => controller.selectIndex.value = index,
          backgroundColor: darkMode ? AColors.black : Colors.white,
          indicatorColor: darkMode ? AColors.white.withOpacity(0.1) : AColors.black.withOpacity(0.1),

          destinations: const [
            NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
            NavigationDestination(icon: Icon(Icons.favorite), label: 'Favourites'),
            NavigationDestination(icon: Icon(Icons.door_sliding), label: 'Wardrobe'),
            NavigationDestination(icon: Icon(Icons.settings), label: 'Settings'),
          ],
        ),
      ),
      body: Obx(() => controller.screens[controller.selectIndex.value]),
    );
  }
}

class NavigationController extends GetxController{
  final Rx<int> selectIndex = 0.obs;

  final screens = [const HomePage() ,const FavouritePage() , WardrobePage(), const SettingsPage()];
  @override
  void onInit() {
    super.onInit();
    selectIndex.value = 0;  // Ensure the home page is selected when the controller is initialized
  }
}
