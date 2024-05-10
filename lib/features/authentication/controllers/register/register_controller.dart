import 'package:aiapparel/data/repositories/authentication/authentication_repository.dart';
import 'package:aiapparel/data/repositories/user/user_repository.dart';
import 'package:aiapparel/features/authentication/views/register/verify_email.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:aiapparel/utils/popups/full_page_loader.dart';
import 'package:aiapparel/utils/constants/image_strings.dart';

import '../../../../utils/helpers/network_manager.dart';
import '../../../../utils/popups/loaders.dart';
import '../../models/users/user_model.dart';

class RegisterController extends GetxController {
  static RegisterController get instance => Get.find();

  final hidePassword = true.obs;
  final privacyPolicy = true.obs;
  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final username = TextEditingController();
  final email = TextEditingController();
  final phoneNumber = TextEditingController();
  final gender = 'Male'.obs; // Set initial value to one of the options
  final dob = TextEditingController(); // Added Date of Birth field
  final password = TextEditingController();
  GlobalKey<FormState> registerFormKey = GlobalKey<FormState>();

  final List<String> genderOptions = ['Male', 'Female', 'Other']; // Define gender options

  void register() async {
    try {
      AFullPageLoader.openLoadingDialog('We are processing your information...', AImages.docerAnimation);

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) return;

      if(!registerFormKey.currentState!.validate()) return;

      if (!privacyPolicy.value) {
        ALoaders.warningSnackBar(
          title: 'Accept Privacy Policy',
          message: 'In order to create account, you must ead and accept the Privacy Policy & Terms of Use.'
        );
        return;
      }

      final userCredential = await AuthenticationRepository.instance.registerWithEmailAndPassword(email.text.trim(), password.text.trim());

      final newUser = UserModel(
          id: userCredential.user!.uid,
          firstName: firstName.text.trim(),
          lastName: lastName.text.trim(),
          username: username.text.trim(),
          email: email.text.trim(),
          phoneNumber: phoneNumber.text.trim(),
          gender: gender.value, // Changed to use RxString value
          dob: dob.text.trim(), // Assigning Date of Birth value
          profilePicture: ''
      );

      final userRepository = Get.put(UserRepository());
      await userRepository.saveUserRecord(newUser);

      AFullPageLoader.stopLoading();

      ALoaders.successSnackBar(title:'Congratulations', message: 'Your account has been created! Verify email to continue. ');

      Get.to(() => VerifyEmailPage(email: email.text.trim()));

    } catch (e) {
      AFullPageLoader.stopLoading();
      ALoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());

    } finally {
      AFullPageLoader.stopLoading();
    }
  }
}