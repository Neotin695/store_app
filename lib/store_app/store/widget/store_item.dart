import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:store_app/core/services/common.dart';
import 'package:store_app/core/theme/colors/landk_colors.dart';
import 'package:store_app/core/tools/tools_widget.dart';
import 'package:store_app/store_app/store/bloc/store_bloc.dart';
import 'package:store_app/store_app/store/repository/src/models/category.dart';
import 'package:store_app/store_app/store/repository/src/models/store.dart';
import 'package:store_app/store_app/store/repository/src/store_repository.dart';

import '../../../core/theme/fonts/landk_fonts.dart';
import '../view/store_page.dart';

class StoreItem extends StatefulWidget {
  const StoreItem({super.key, required this.store});

  final Store store;

  @override
  State<StoreItem> createState() => _StoreItemState();
}

class _StoreItemState extends State<StoreItem> {
  late final StoreBloc bloc;

  @override
  void initState() {
    bloc = BlocProvider.of<StoreBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (bloc.storeCategory == StoreCategory.empty()) {
      bloc.add(PopulateStoreCategory(categoryId: widget.store.category));
    }
    return InkWell(
      onTap: () {
        Navigator.push(
          Common.scaffoldState.currentContext!,
          MaterialPageRoute(
            builder: (_) => StorePage(
              store: widget.store,
              category: bloc.storeCategory,
              storeRepository: StoreRepository(),
            ),
          ),
        );
      },
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 3,
        child: Column(
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomEnd,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: CachedNetworkImage(
                    fit: BoxFit.cover,
                    height: 20.h,
                    width: double.infinity,
                    imageUrl: widget.store.coverUrl,
                    placeholder: (context, url) => loadingWidget(),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: widget.store.active ? green : orange,
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
                  margin: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
                  child: Text(
                    widget.store.active
                        ? trans(context).open
                        : trans(context).closed,
                    style: h5.copyWith(
                        color: !widget.store.active ? black : white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Align(
                  alignment: AlignmentDirectional.topStart,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(360),
                      color: white,
                    ),
                    margin:
                        EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
                    padding: const EdgeInsets.all(5),
                    child: const Icon(Icons.favorite_outline_sharp),
                  ),
                ),
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
                        widget.store.name,
                        style: h4,
                      ),
                      hSpace(2),
                      Icon(
                        Icons.star,
                        color: yellow,
                      )
                    ],
                  ),
                  Text(
                    locale(context)
                        ? bloc.storeCategory.nameAr
                        : bloc.storeCategory.nameEn,
                    style: h4,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
