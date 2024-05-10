import 'package:aiapparel/features/authentication/controllers/user/user_controller.dart';
import 'package:aiapparel/utils/constants/image_strings.dart';
import 'package:aiapparel/utils/popups/full_page_loader.dart';
import 'package:aiapparel/utils/popups/loaders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../../data/repositories/authentication/authentication_repository.dart';
import '../../../../utils/helpers/network_manager.dart';

class LoginController extends GetxController {

  final rememberMe = false.obs;
  final hidePassword = true.obs;
  final localStorage = GetStorage();
  final email = TextEditingController();
  final password = TextEditingController();
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  final userController = Get.put(UserController());


  @override
  void onInit() {
    email.text = localStorage.read('REMEMBER_ME_EMAIL') ?? '';
    password.text = localStorage.read('REMEMBER_ME_PASSWORD') ?? '';
    super.onInit();
  }

  Future<void> emailAndPasswordSignIn() async {
    try {
      AFullPageLoader.openLoadingDialog('Logging you in ...', AImages.docerAnimation);

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        AFullPageLoader.stopLoading();
        return;
      }

      if(!loginFormKey.currentState!.validate()) {
        AFullPageLoader.stopLoading();
        return;
      }

      if (rememberMe.value) {
        localStorage.write('REMEMBER_ME_EMAIL', email.text.trim());
        localStorage.write('REMEMBER_ME_PASSWORD', password.text.trim());
      }

      final userCredentials = await AuthenticationRepository.instance.loginWithEmailAndPassword(email.text.trim(), password.text.trim());

      AFullPageLoader.stopLoading();

      AuthenticationRepository.instance.screenRedirect();
    } catch (e) {
      AFullPageLoader.stopLoading();
      ALoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    }
  }

  Future<void> googleSignIn() async {
    try {
      AFullPageLoader.openLoadingDialog('Logging you in...', AImages.docerAnimation);

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        AFullPageLoader.stopLoading();
        return;
      }

      final userCredentials = await AuthenticationRepository.instance.signInWithGoogle();

      await userController.saveUserRecord(userCredentials);

      AFullPageLoader.stopLoading();

      AuthenticationRepository.instance.screenRedirect();
    } catch (e) {
      ALoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    }
  }
}