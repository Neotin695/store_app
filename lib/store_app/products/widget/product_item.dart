import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sizer/sizer.dart';
import 'package:store_app/core/theme/colors/landk_colors.dart';
import 'package:store_app/core/theme/fonts/landk_fonts.dart';
import 'package:store_app/core/tools/tools_widget.dart';
import 'package:store_app/store_app/products/repository/model/porduct_model.dart';
import 'package:store_app/store_app/store/bloc/store_bloc.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 3.w),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Image.network(
              product.coverUrl,
              fit: BoxFit.cover,
              width: 10.w,
              height: 10.h,
            ),
            hSpace(2),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(locale(context) ? product.titleAr : product.titleEn,
                    style: h4),
                // IconButton(onPressed: () {}, icon: const Icon(Icons.favorite))
                Text(
                  '${product.price}',
                  style: bold,
                ),
              ],
            ),
            const Spacer(),
            Column(
              children: [
                InkWell(
                  onTap: () {
                    if (FirebaseAuth.instance.currentUser == null) {
                      Fluttertoast.showToast(
                        msg: trans(context).plsLogin,
                        backgroundColor: orange,
                        textColor: black,
                      );
                    } else {
                      context
                          .read<StoreBloc>()
                          .add(AddToCart(productId: product.id));
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(360),
                      color: orange,
                    ),
                    padding:
                        EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
                    margin:
                        EdgeInsets.symmetric(horizontal: 1.w, vertical: 1.h),
                    child: Icon(
                      Icons.add,
                      size: 14.sp,
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: product.active ? green : orange,
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
                  margin: EdgeInsets.symmetric(horizontal: 1.w, vertical: 1.h),
                  child: Text(
                    product.active
                        ? trans(context).available
                        : trans(context).unAvailable,
                    style: h5.copyWith(
                        color: !product.active ? black : white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
