import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:store_app/core/theme/fonts/landk_fonts.dart';
import 'package:store_app/core/tools/tools_widget.dart';

import '../bloc/category_bloc.dart';
import '../view/show_all_categories_view.dart';

class CategoryWidget extends StatefulWidget {
  const CategoryWidget({super.key});

  @override
  State<CategoryWidget> createState() => _CategoryWidgetState();
}

class _CategoryWidgetState extends State<CategoryWidget> {
  late final CategoryBloc bloc;

  @override
  void initState() {
    bloc = BlocProvider.of<CategoryBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 3.w,
      ),
      child: BlocBuilder<CategoryBloc, CategoryState>(
        builder: (context, state) {
          if (state is CategoryLoading) return loadingWidget();
          if (state is CategoryFailure) {
            return empty();
          }

          if (state is CategoryLoaded) {
            return Column(
              children: [
                ListTile(
                  title: Text(trans(context).categories),
                  trailing: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              ShowAllCategoriesPage(categories: state.category),
                        ),
                      );
                    },
                    child: Text(trans(context).showMore),
                  ),
                ),
                SizedBox(
                  height: 15.h,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: state.category
                        .map(
                          (e) => Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 7),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                CachedNetworkImage(
                                  width: 20.w,
                                  height: 10.h,
                                  imageUrl: e.imageUrl,
                                  fit: BoxFit.cover,
                                  placeholder: (_, url) => loadingWidget(),
                                ),
                                vSpace(1),
                                Text(
                                  locale(context) ? e.nameAr : e.nameEn,
                                  style: bold,
                                )
                              ],
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),
              ],
            );
          }
          return empty();
        },
      ),
    );
  }
}
