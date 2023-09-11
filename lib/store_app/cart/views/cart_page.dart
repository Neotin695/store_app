import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app/store_app/cart/repository/cart_repository.dart';

import '../bloc/cart_bloc.dart';

class CartPage extends StatelessWidget {
  static Page page() =>
      MaterialPage(child: CartPage(cartRepository: CartRepository()));
  const CartPage({super.key, required this.cartRepository});
  final CartRepository cartRepository;
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: cartRepository,
      child: BlocProvider(
        create: (context) => CartBloc(),
        child: Container(),
      ),
    );
  }
}
