import 'package:aiapparel/features/authentication/views/login/login.dart';
import 'package:aiapparel/features/authentication/views/passwords/forget_password.dart';
import 'package:aiapparel/features/authentication/views/register/register.dart';
import 'package:aiapparel/features/pages/favourites/favourites.dart';
import 'package:aiapparel/features/pages/home/home.dart';
import 'package:aiapparel/features/pages/settings/profile.dart';
import 'package:aiapparel/features/pages/settings/settings.dart';
import 'package:aiapparel/features/pages/wardrobe/wardrobe.dart';
import 'package:aiapparel/routes/routes.dart';
import 'package:get/get.dart';

class AppRoutes {
  static final pages = [
    GetPage(name: ARoutes.home, page: () => const HomePage()),
    GetPage(name: ARoutes.favourites, page: () => const FavouritePage()),
    GetPage(name: ARoutes.wardrobe, page: () =>  WardrobePage()),
    GetPage(name: ARoutes.settings, page: () => const SettingsPage()),
    GetPage(name: ARoutes.userProfile, page: () => const Profile()),
    GetPage(name: ARoutes.signIn, page: () => const Login()),
    GetPage(name: ARoutes.forgetPassword, page: () => const ForgetPassword()),
    GetPage(name: ARoutes.register, page: () => const Register()),
  ];
}