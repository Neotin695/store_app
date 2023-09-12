import 'package:flutter/material.dart';
import 'package:store_app/core/tools/tools_widget.dart';
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
    return Column(
      children: [
        BannerPage(
          bannerRepository: BannerRepository(),
        ),
        CategoryPage(
          categoryRepository: CategoryRepository(),
        ),
        ListTile(
          title: Text(trans(context).store),
          trailing: TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => StoresPage(
                    storeRepository: StoreRepository(),
                  ),
                ),
              );
            },
            child: Text(trans(context).showMore),
          ),
        ),
        StoresPage(storeRepository: StoreRepository())
      ],
    );
  }
}
