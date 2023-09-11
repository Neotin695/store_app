import 'package:flutter/material.dart';
import 'package:store_app/store_app/banners/reppository/banners_repository.dart';
import 'package:store_app/store_app/banners/view/banner_page.dart';

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
      ],
    );
  }
}
