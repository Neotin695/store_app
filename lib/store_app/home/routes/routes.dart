import 'package:flutter/material.dart';
import 'package:store_app/store_app/profile/views/profile_page.dart';

import '../../cart/views/cart_page.dart';
import '../widgets/home_page.dart';
import '../widgets/menu_page.dart';

enum HomeState {
  home,
  cart,
  menu,
  profile,
}

List<Page> onGenerateHomePage(HomeState state, List<Page> pages) {
  switch (state) {
    case HomeState.home:
      return [HomePage.page()];

    case HomeState.menu:
      return [MenuPage.page()];
    case HomeState.profile:
      return [ProfilePage.page()];
    case HomeState.cart:
      return [CartPage.page()];
  }
}
