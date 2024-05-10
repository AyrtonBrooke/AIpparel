import 'package:aiapparel/data/repositories/user/user_repository.dart';
import 'package:aiapparel/features/pages/settings/profile.dart';
import 'package:aiapparel/utils/helpers/network_manager.dart';
import 'package:aiapparel/utils/popups/full_page_loader.dart';
import 'package:aiapparel/utils/popups/loaders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../utils/constants/image_strings.dart';
import '../user/user_controller.dart';

class UpdateNameController extends GetxController {
  static UpdateNameController get instance => Get.find();

  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final username = TextEditingController();
  final phoneNumber = TextEditingController();
  final gender = 'Male'.obs; // Set initial value to one of the options
  final dob = TextEditingController();
  final userController = UserController.instance;
  final userRepository = Get.put(UserRepository());
  GlobalKey<FormState> updateUserNameFormKey = GlobalKey<FormState>();

  final List<String> genderOptions = ['Male', 'Female', 'Other']; // Define gender options

  @override
  void onInit() {
    initNames();
    super.onInit();
  }

  Future<void> initNames() async {
    firstName.text = userController.user.value.firstName;
    lastName.text = userController.user.value.lastName;
    username.text = userController.user.value.username;
    phoneNumber.text = userController.user.value.phoneNumber;
    gender.value = userController.user.value.gender;
    dob.text = userController.user.value.dob;
  }

  Future<void> updateFields() async {
    try {
      AFullPageLoader.openLoadingDialog('Updating...', AImages.success);

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        AFullPageLoader.stopLoading();
        return;
      }

      if (!updateUserNameFormKey.currentState!.validate()) {
        AFullPageLoader.stopLoading();
        return;
      }

      Map<String, dynamic> name = {
        'FirstName': firstName.text.trim(),
        'LastName': lastName.text.trim(),
        'Username': username.text.trim(),
        'PhoneNumber': phoneNumber.text.trim(),
        'Gender': gender.value.trim(),
        'DateOfBirth': dob.text.trim()
      };
      await userRepository.updateSingleField(name);

      userController.user.value.firstName = firstName.text.trim();
      userController.user.value.lastName = lastName.text.trim();
      userController.user.value.username = username.text.trim();
      userController.user.value.phoneNumber = phoneNumber.text.trim();
      userController.user.value.gender = gender.value.trim();
      userController.user.value.dob = dob.text.trim();

      AFullPageLoader.stopLoading();

      ALoaders.successSnackBar(title: 'Congrats', message: 'Field has been updated');

      Get.off(() => const Profile());
    } catch (e) {
      AFullPageLoader.stopLoading();
      ALoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    }
  }
}
