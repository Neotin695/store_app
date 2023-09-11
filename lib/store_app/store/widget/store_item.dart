import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:store_app/core/theme/colors/landk_colors.dart';
import 'package:store_app/core/tools/tools_widget.dart';
import 'package:store_app/store_app/store/repository/src/models/store.dart';

import '../../../core/theme/fonts/landk_fonts.dart';

class StoreItem extends StatelessWidget {
  const StoreItem({super.key, required this.store});

  final Store store;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 3,
      child: Column(
        children: [
          Stack(
            alignment: autoAlignBottom(context),
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: CachedNetworkImage(
                  fit: BoxFit.cover,
                  height: 20.h,
                  width: double.infinity,
                  imageUrl: store.coverUrl,
                  placeholder: (context, url) => loadingWidget(),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: store.active ? green : orange,
                ),
                padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
                margin: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
                child: Text(
                  store.active ? trans(context).open : trans(context).closed,
                  style: h5.copyWith(
                      color: !store.active ? black : white,
                      fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
          vSpace(1),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 3.w),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      store.name,
                      style: h4,
                    ),
                    hSpace(2),
                    Icon(
                      Icons.star,
                      color: yellow,
                    )
                  ],
                ),
                Text(store.addressInfo.specialMarque),
              ],
            ),
          )
        ],
      ),
    );
  }
}
