import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../store_app/cart/repository/cart_repository.dart';

class Common {
  //static LangSerivce langSerivce = LangSerivce();
  static late SharedPreferences prefs;

  static final GlobalKey<ScaffoldState> scaffoldState = GlobalKey();
  static final GlobalKey<ScaffoldState> storesScaffold = GlobalKey();

  static Cart cart = Cart.empty();
}
