import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:store_app/core/tools/tools_widget.dart';
import 'package:store_app/store_app/categories/reppository/category_repository.dart';

import '../../../core/theme/fonts/landk_fonts.dart';

class ShowAllCategoriesPage extends StatefulWidget {
  const ShowAllCategoriesPage({super.key, required this.categories});
  final List<Category> categories;

  @override
  State<ShowAllCategoriesPage> createState() => _ShowAllCategoriesViewState();
}

class _ShowAllCategoriesViewState extends State<ShowAllCategoriesPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.count(
        crossAxisCount: 3,
        children: widget.categories
            .map(
              (e) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CachedNetworkImage(
                      height: 11.h,
                      imageUrl: e.imageUrl,
                      fit: BoxFit.cover,
                      placeholder: (_, url) => loadingWidget(),
                    ),
                    vSpace(1),
                    Text(
                      locale(context) ? e.nameAr : e.nameEn,
                      style: bold.copyWith(fontSize: h4.fontSize),
                    )
                  ],
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
