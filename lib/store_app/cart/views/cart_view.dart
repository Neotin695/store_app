import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:store_app/core/constances/media_const.dart';
import 'package:store_app/core/shared/counter.dart';
import 'package:store_app/core/shared/empty_data.dart';
import 'package:store_app/core/tools/tools_widget.dart';
import 'package:store_app/store_app/cart/bloc/cart_bloc.dart';
import 'package:store_app/store_app/products/repository/model/porduct_model.dart';

import '../../../core/theme/colors/landk_colors.dart';
import '../../../core/theme/fonts/landk_fonts.dart';

class CartView extends StatefulWidget {
  const CartView({super.key});

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  late final CartBloc bloc;

  @override
  void initState() {
    bloc = BlocProvider.of<CartBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          BlocBuilder<CartBloc, CartState>(
            builder: (context, state) {
              if (state is CartLoading) return loadingWidget();
              if (state is CartFailure) return empty();
              if (state is CartLoaded) {
                if (state.cart.quantities.isEmpty) {
                  return EmptyData(
                      assetIcon: iEmpty,
                      title: trans(context).explorerProducts);
                }
                final prodcutIds = List<String>.from(
                  state.cart.quantities.map<String>((e) => e.productId),
                );
                return StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('products')
                      .where(
                        'id',
                        whereIn: prodcutIds,
                      )
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final products = List<Product>.from(snapshot.data!.docs
                          .map((e) => Product.fromMap(e.data())));

                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: products.length,
                        itemBuilder: (context, index) {
                          final product = products[index];
                          return Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CachedNetworkImage(
                                  imageUrl: product.coverUrl,
                                  fit: BoxFit.cover,
                                  width: 20.w,
                                ),
                              ),
                              hSpace(2),
                              Text(
                                locale(context)
                                    ? product.titleAr
                                    : product.titleEn,
                              ),
                              const Spacer(),
                              Column(
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        bloc.add(RemoveFromCart(
                                            count:
                                                state.cart.quantities[index]));
                                      },
                                      icon: const Icon(Icons.delete)),
                                  CounterWidget(
                                    counter:
                                        state.cart.quantities[index].quantity,
                                    onIncrease: () {
                                      bloc.add(
                                        IncreaseQuantity(
                                          count: state.cart.quantities[index]
                                              .copyWith(
                                                  quantity: ++state
                                                      .cart
                                                      .quantities[index]
                                                      .quantity),
                                        ),
                                      );
                                    },
                                    onDecrease: () {
                                      if (state
                                              .cart.quantities[index].quantity >
                                          1) {
                                        bloc.add(
                                          DecreaseQuantity(
                                            count: state.cart.quantities[index]
                                                .copyWith(
                                                    quantity: --state
                                                        .cart
                                                        .quantities[index]
                                                        .quantity),
                                          ),
                                        );
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ],
                          );
                        },
                      );
                    }
                    return empty();
                  },
                );
              }
              return empty();
            },
          ),
          const Spacer(),
          ElevatedButton.icon(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: orange,
              shape: const RoundedRectangleBorder(),
              minimumSize: Size(100.w, 7.h),
            ),
            label: Text(
              trans(context).checkout,
              style: h4.copyWith(color: black),
            ),
            icon: Icon(
              Icons.shopping_cart_checkout,
              color: black,
            ),
          ),
        ],
      ),
    );
  }
}
