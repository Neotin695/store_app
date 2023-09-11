import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:store_app/core/constances/media_const.dart';
import 'package:store_app/core/shared/empty_data.dart';
import 'package:store_app/core/tools/tools_widget.dart';
import 'package:store_app/store_app/products/bloc/products_bloc.dart';
import 'package:store_app/store_app/products/widget/product_item.dart';


class ProductView extends StatefulWidget {
  const ProductView({super.key});

  @override
  State<ProductView> createState() => _ProductViewState();
}

class _ProductViewState extends State<ProductView> {
  late final ProductsBloc bloc;
  @override
  void initState() {
    bloc = BlocProvider.of<ProductsBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<ProductsBloc, ProductsState>(
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
