import 'package:aiapparel/data/repositories/banners/banner_repository.dart';
import 'package:aiapparel/features/pages/home/models/banner_model.dart';
import 'package:get/get.dart';

import '../../../../utils/popups/loaders.dart';

class BannerController extends GetxController {

  final carousalCurrentIndex = 0.obs;
  final isLoading = false.obs;
  final RxList<BannerModel> banners = <BannerModel>[].obs;

  @override
  void onInit() {
    fetchBanners();
    super.onInit();
  }

  void updatePageIndicator(index) {
    carousalCurrentIndex.value = index;
  }

  Future<void> fetchBanners() async {
    try {
      isLoading.value = true;

      final bannerRepo = Get.put(BannerRepository());
      final banners = await bannerRepo.fetchBanners();

      this.banners.assignAll(banners);

    } catch (e) {
      ALoaders.errorSnackBar(title: 'Oh snap', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}