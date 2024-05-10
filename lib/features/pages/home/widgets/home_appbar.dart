import 'package:aiapparel/common/widgets/appbar/appbar.dart';
import 'package:aiapparel/common/widgets/shimmer/shimmer.dart';
import 'package:aiapparel/features/authentication/controllers/user/user_controller.dart';
import 'package:aiapparel/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AHomeAppBar extends StatelessWidget {
  const AHomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UserController());
    return AAppBar(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Welcome', style: Theme.of(context).textTheme.labelMedium!.apply(color: AColors.grey)),
          Obx(() {
            if(controller.profileLoading.value){
              return const AShimmerEffect(width: 80, height: 50);
            } else {
              return Text(controller.user.value.fullName, style: Theme.of(context).textTheme.titleLarge!.apply(color: AColors.grey));
            }
          }),
        ],
      ),
    );
  }
}
