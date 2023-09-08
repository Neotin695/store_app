import 'package:flutter/material.dart';
import 'package:store_app/store_app/products/presentation/view/products_page.dart';

class HomePage extends StatelessWidget {
  static Page page() => const MaterialPage(child: HomePage());
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const ProductsPage();
  }
}
