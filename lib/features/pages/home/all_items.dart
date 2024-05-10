import 'package:aiapparel/common/layouts/grid_layout.dart';
import 'package:aiapparel/common/widgets/appbar/appbar.dart';
import 'package:aiapparel/common/widgets/cards/vertical_card.dart';
import 'package:aiapparel/features/pages/home/widgets/sortable_items.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:get/get.dart';

import '../../../common/widgets/shimmer/vertical_items_shimmer.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/helpers/cloud_helper_functions.dart';
import 'controllers/all_items_controller.dart';
import 'controllers/item_controller.dart';
import 'models/item_model.dart';

class AllItems extends StatelessWidget {
  const AllItems({super.key, required this.title, this.query, this.futureMethod});

  final String title;
  final Query? query;
  final Future<List<ItemModel>>? futureMethod;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AllItemsController());
    return Scaffold(
      appBar: const AAppBar(title: Text('Popular Items'), showBackArrow: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(ASizes.defaultSpace),
          child: FutureBuilder(
            future: futureMethod ?? controller.fetchItemsByQuery(query),
            builder: (context, snapshot) {
              const loader = AVerticalItemShimmer();
              final widget = ACloudHelperFunctions.checkMultiRecordState(snapshot: snapshot, loader: loader);

              if(widget != null) return widget;

              final items = snapshot.data!;

              return ASortableItems(items: items);
            },
          ),
        ),
      ),
    );
  }
}

