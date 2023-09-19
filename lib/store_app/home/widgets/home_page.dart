import 'package:flutter/material.dart';
import 'package:store_app/store_app/banners/reppository/banners_repository.dart';
import 'package:store_app/store_app/banners/view/banner_page.dart';
import 'package:store_app/store_app/categories/reppository/category_repository.dart';
import 'package:store_app/store_app/store/repository/src/store_repository.dart';

import '../../categories/view/category_page.dart';
import '../../store/view/stores_page.dart';

class HomePage extends StatelessWidget {
  static Page page() => const MaterialPage(child: HomePage());
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverList(
          delegate: SliverChildListDelegate(
            [
              BannerPage(
                bannerRepository: BannerRepository(),
              ),
              CategoryPage(
                categoryRepository: CategoryRepository(),
              ),
            ],
          ),
        ),
        SliverList(
          delegate: SliverChildListDelegate(
            [
              StoresPage(storeRepository: StoreRepository()),
            ],
          ),
        ),
      ],
    );
  }
}
