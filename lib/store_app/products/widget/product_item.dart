import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:store_app/core/theme/colors/landk_colors.dart';
import 'package:store_app/core/theme/fonts/landk_fonts.dart';
import 'package:store_app/core/tools/tools_widget.dart';
import 'package:store_app/store_app/products/repository/model/porduct_model.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(5.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Image.network(
              product.coverUrl,
              fit: BoxFit.cover,
              width: 10.w,
              height: 10.h,
            ),
            vSpace(2),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(locale(context) ? product.titleAr : product.titleEn,
                    style: h5),
                IconButton(onPressed: () {}, icon: const Icon(Icons.favorite))
              ],
            ),
            vSpace(1),
            Text(
              '\$${product.price}',
              style: h5.copyWith(color: orange),
            ),
          ],
        ),
      ),
    );
  }
}
