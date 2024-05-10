import 'package:aiapparel/features/authentication/controllers/user/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../../utils/constants/colors.dart';
import '../images/circular_images.dart';

class AUserProfileTile extends StatelessWidget {
  const AUserProfileTile({
    super.key, required this.onPressed,
  });

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    return ListTile(
      leading: ACircularImage(
        image: controller.user.value.profilePicture,
        width: 50,
        height: 50,
        padding: 0,
      ),
      title: Text(controller.user.value.fullName,
          style: Theme.of(context)
              .textTheme
              .bodyMedium!
              .apply(color: AColors.white)),
      subtitle: Text(controller.user.value.email,
          style: Theme.of(context)
              .textTheme
              .bodyMedium!
              .apply(color: AColors.white)),
      trailing: IconButton(
          onPressed: onPressed,
          icon: const Icon(Iconsax.edit, color: AColors.white)),
    );
  }
}
