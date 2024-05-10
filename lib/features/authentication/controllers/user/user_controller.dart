import 'package:aiapparel/data/repositories/authentication/authentication_repository.dart';
import 'package:aiapparel/data/repositories/user/user_repository.dart';
import 'package:aiapparel/utils/popups/full_page_loader.dart';
import 'package:aiapparel/utils/popups/loaders.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/network_manager.dart';
import '../../../pages/settings/re_auth_user_login_form.dart';
import '../../models/users/user_model.dart';
import '../../views/login/login.dart';

class UserController extends GetxController {
  static UserController get instance => Get.find();

  Rx<UserModel> user = UserModel.empty().obs;
  final userRepository = Get.put(UserRepository());
  final profileLoading = false.obs;
  final hidePassword = false.obs;
  final imageUploading = false.obs;
  final verifyEmail = TextEditingController();
  final verifyPassword = TextEditingController();
  GlobalKey<FormState> reAuthFormKey = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();
    fetchUserRecord();
  }

  Future<void> fetchUserRecord() async {
    try {
      profileLoading.value = true;
      final user = await userRepository.fetchUserDetails();
      this.user(user);
    } catch (e) {
      user(UserModel.empty());
    } finally {
      profileLoading.value = false;
    }
  }

  Future<void> saveUserRecord(UserCredential? userCredentials) async {
    try {
      await fetchUserRecord();

      if (user.value.id.isEmpty){
        if (userCredentials != null) {
          final nameParts =
          UserModel.nameParts(userCredentials.user!.displayName ?? '');
          final username =
          UserModel.generateUsername(userCredentials.user!.displayName ?? '');

          final user = UserModel(
              id: userCredentials.user!.uid,
              firstName: nameParts[0],
              lastName: nameParts.length > 1 ? nameParts.sublist(1).join(' ') : '',
              username: username,
              email: userCredentials.user!.email ?? '',
              phoneNumber: userCredentials.user!.phoneNumber ?? '',
              gender: '', // Initialize gender to empty string
              dob: '', // Initialize Date of Birth to empty string
              profilePicture: userCredentials.user!.photoURL ?? '');
          await userRepository.saveUserRecord(user);
        }
      }
    } catch (e) {
      ALoaders.warningSnackBar(
          title: 'Data not saved',
          message:
              'Something went wrong while saving your information. you can re-save your data in your profile');
    }
  }

  void deleteAccountWarningPopup() {
    Get.defaultDialog(
      contentPadding: const EdgeInsets.all(ASizes.md),
      title: 'Delete Account',
      middleText: 'Are you sure you want to delete your account',
      confirm: ElevatedButton(onPressed: () async => deleteUserAccount(),
          style: ElevatedButton.styleFrom(backgroundColor: Colors.red, side: const BorderSide(color: Colors.red)),
          child: const Padding(padding: EdgeInsets.symmetric(horizontal: ASizes.lg), child: Text('Delete'))
      ),
      cancel: OutlinedButton(
          child: const Text('Cancel'),
          onPressed: () => Navigator.of(Get.overlayContext!).pop(),
      ),
    );
  }

  void deleteUserAccount() async {
    try {
      AFullPageLoader.openLoadingDialog('Processing', AImages.success);

      final auth = AuthenticationRepository.instance;
      final provider = auth.authUser!.providerData.map((e) => e.providerId).first;
      if (provider.isNotEmpty) {
        if(provider == 'google.com') {
          await auth.signInWithGoogle();
          await auth.deleteAccount();
          AFullPageLoader.stopLoading();
          Get.offAll(() => const ReAuthLoginForm());
        } else if (provider == 'password') {
          AFullPageLoader.stopLoading();
          Get.to(() => const ReAuthLoginForm());
        }
      }
    } catch (e) {
      AFullPageLoader.stopLoading();
      ALoaders.warningSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }

  Future<void> reAuthenticateEmailAndPasswordUser() async {
    try {
      AFullPageLoader.openLoadingDialog('Processing', AImages.success);

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        AFullPageLoader.stopLoading();
        return;
      }

      if (!reAuthFormKey.currentState!.validate()) {
        AFullPageLoader.stopLoading();
        return;
      }

      await AuthenticationRepository.instance
          .reAuthenticateWithEmailAndPassword(
          verifyEmail.text.trim(), verifyPassword.text.trim());
      await AuthenticationRepository.instance.deleteAccount();
      AFullPageLoader.stopLoading();
      Get.offAll(() => const Login());
    } catch (e) {
      AFullPageLoader.stopLoading();
      ALoaders.warningSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }

  uploadUserProfilePicture() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery, imageQuality: 70, maxHeight: 512, maxWidth: 512);
      if (image != null) {
        imageUploading.value = true;
        final imageUrl = await userRepository.uploadImage('Users/Images/Profile/', image);

        Map<String, dynamic> json = {'ProfilePicture': imageUrl};
        await userRepository.updateSingleField(json);

        user.value.profilePicture = imageUrl;
        user.refresh();

        ALoaders.successSnackBar(title: 'Congrats', message: 'Profile Image Updated');
      }
    } catch (e) {
      ALoaders.errorSnackBar(title: 'Oh Snap', message: 'Something went wrong: $e');
    } finally {
      imageUploading.value = false;
    }
  }
}
