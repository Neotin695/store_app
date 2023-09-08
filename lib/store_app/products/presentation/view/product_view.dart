import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:store_app/core/constances/media_const.dart';
import 'package:store_app/core/shared/empty_data.dart';
import 'package:store_app/core/tools/tools_widget.dart';
import 'package:store_app/store_app/products/presentation/widget/product_item.dart';

import '../bloc/product_bloc.dart';

class ProductView extends StatefulWidget {
  const ProductView({super.key});

  @override
  State<ProductView> createState() => _ProductViewState();
}

class _ProductViewState extends State<ProductView> {
  late final ProductBloc bloc;
  @override
  void initState() {
    bloc = BlocProvider.of<ProductBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<ProductBloc, ProductState>(
          builder: (context, state) {
            if (state is ProductsLoaded) {
              return SizedBox(
                height: 26.h,
                child: ListView.builder(
                  itemCount: state.products.length,
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final product = state.products[index];
                    return ProductItem(product: product);
                  },
                ),
              );
            } else if (state is ProductsLoading) {
              return loadingWidget();
            } else {
              return EmptyData(
                title: 'No Product yet',
                assetIcon: iEmpty,
              );
            }
          },
        ),
      ),
    );
  }
}
