import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:store_app/store_app/products/widget/product_item.dart';
import 'package:store_app/store_app/store/repository/src/models/store.dart';

import '../../../core/theme/colors/landk_colors.dart';
import '../../../core/theme/fonts/landk_fonts.dart';
import '../../../core/tools/tools_widget.dart';
import '../bloc/store_bloc.dart';
import '../repository/src/models/category.dart';

class StoreView extends StatefulWidget {
  const StoreView({super.key, required this.store, required this.category});
  final Store store;
  final StoreCategory category;

  @override
  State<StoreView> createState() => _StoreViewState();
}

class _StoreViewState extends State<StoreView> {
  late final StoreBloc bloc;
  @override
  void initState() {
    bloc = BlocProvider.of<StoreBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                Stack(
                  children: [
                    CachedNetworkImage(
                      fit: BoxFit.cover,
                      height: 20.h,
                      width: double.infinity,
                      imageUrl: widget.store.coverUrl,
                      placeholder: (context, url) => loadingWidget(),
                    ),
                    Align(
                      alignment: AlignmentDirectional.topStart,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(360),
                          color: white,
                        ),
                        margin: EdgeInsets.symmetric(
                            horizontal: 3.w, vertical: 1.h),
                        padding: const EdgeInsets.all(5),
                        child: const Icon(Icons.favorite_outline_sharp),
                      ),
                    ),
                  ],
                ),
                vSpace(1),
                Column(
                  children: [
                    Container(
                      height: 21.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 3.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.store.name,
                                style: h3.copyWith(fontWeight: bold.fontWeight),
                              ),
                              Text(
                                locale(context)
                                    ? widget.category.nameAr
                                    : widget.category.nameEn,
                                style: bold,
                              ),
                            ],
                          ),
                          hSpace(2),
                          Icon(
                            Icons.star,
                            color: yellow,
                          ),
                          const Spacer(),
                          CircleAvatar(
                            radius: 25.sp,
                            foregroundImage: NetworkImage(widget.store.logoUrl),
                          )
                        ],
                      ),
                    ),
                    ListTile(
                      title: Text(
                        trans(context).products,
                        style: h4.copyWith(fontWeight: bold.fontWeight),
                      ),
                    ),
                    BlocBuilder<StoreBloc, StoreState>(
                      builder: (context, state) {
                        if (state is StoreLoading) return loadingWidget();
                        if (state is StoreFailure) return empty();
                        if (state is ProductLoaded) {
                          return Expanded(
                            child: ListView(
                              children: state.products.map((e) {
                                return ProductItem(product: e);
                              }).toList(),
                            ),
                          );
                        }
                        return empty();
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          Row(
            children: [
              ElevatedButton.icon(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: orange,
                  shape: const RoundedRectangleBorder(),
                  minimumSize: Size(100.w, 7.h),
                ),
                label: Text(
                  trans(context).showCart,
                  style: h4.copyWith(color: black),
                ),
                icon: Icon(
                  Icons.shopping_cart,
                  color: black,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
