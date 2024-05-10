import 'package:aiapparel/features/pages/home/models/category_model.dart';

import '../../features/pages/home/models/banner_model.dart';
import '../../routes/routes.dart';
import '../../utils/constants/image_strings.dart';

class AData {
  static final List<BannerModel> banners = [
    BannerModel(imageUrl: AImages.banner1, targetScreen: ARoutes.itemDetails, active: false),
    BannerModel(imageUrl: AImages.banner2, targetScreen: ARoutes.itemDetails, active: true),
    BannerModel(imageUrl: AImages.banner3, targetScreen: ARoutes.itemDetails, active: false),
    BannerModel(imageUrl: AImages.banner4, targetScreen: ARoutes.itemDetails, active: true),
  ];


  static final List<CategoryModel> categories = [
    CategoryModel(id: '1', name: 'Sports', image: AImages.sportIcon, isFeatured: true),
    CategoryModel(id: '2', name: 'Furniture', image: AImages.furnitureIcon, isFeatured: true),
    CategoryModel(id: '3', name: 'Electronics', image: AImages.electronicsIcon, isFeatured: true),
    CategoryModel(id: '4', name: 'Clothes', image: AImages.clothIcon, isFeatured: true),
    CategoryModel(id: '5', name: 'Animals', image: AImages.animalIcon, isFeatured: true),
    CategoryModel(id: '6', name: 'Shoes', image: AImages.shoeIcon, isFeatured: true),
    CategoryModel(id: '7', name: 'Cosmetics', image: AImages.cosmeticsIcon, isFeatured: true),
    CategoryModel(id: '8', name: 'Jewelery', image: AImages.jeweleryIcon, isFeatured: true),

    ///sub-categories
    CategoryModel(id: '9', name: 'Sport Shoes', image: AImages.sportIcon,parentId: '1', isFeatured: false),
    CategoryModel(id: '10', name: 'Track suits', image: AImages.sportIcon,parentId: '1', isFeatured: false),
    CategoryModel(id: '11', name: 'Sport Shoes', image: AImages.sportIcon,parentId: '1', isFeatured: false),
  ];
}
