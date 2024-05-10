import 'package:aiapparel/data/repositories/authentication/authentication_repository.dart';
import 'package:aiapparel/features/authentication/views/passwords/reset_password.dart';
import 'package:aiapparel/utils/helpers/network_manager.dart';
import 'package:aiapparel/utils/popups/full_page_loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/popups/loaders.dart';

class ForgetPasswordController extends GetxController{
  static ForgetPasswordController get instance => Get.find();

  final email = TextEditingController();
  GlobalKey<FormState> forgetPasswordFormKey = GlobalKey<FormState>();

  sendPasswordResetEmail() async{
    try {
      AFullPageLoader.openLoadingDialog('Processing your request...', AImages.success);

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {AFullPageLoader.stopLoading(); return;}

      if (!forgetPasswordFormKey.currentState!.validate()) {
        AFullPageLoader.stopLoading();
        return;
      }

      await AuthenticationRepository.instance.sendPasswordResetEmail(email.text.trim());

      AFullPageLoader.stopLoading();

      ALoaders.successSnackBar(title: 'Email sent', message: 'Email link sent for password reset'.tr);

      Get.to(() => ResetPassword(email: email.text.trim()));
    } catch (e) {
      AFullPageLoader.stopLoading();
      ALoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    }
  }

  resendPasswordResetEmail(String email) async{
    try {
      AFullPageLoader.openLoadingDialog('Processing your request...', AImages.success);

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {AFullPageLoader.stopLoading(); return;}

      await AuthenticationRepository.instance.sendPasswordResetEmail(email);

      AFullPageLoader.stopLoading();

      ALoaders.successSnackBar(title: 'Email sent', message: 'Email link sent for password reset'.tr);

    } catch (e) {
      AFullPageLoader.stopLoading();
      ALoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    }
  }
}

