import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app/store_app/checkout/bloc/checkout_bloc.dart';
import 'package:store_app/store_app/checkout/repository/src/checkout_repository.dart';
import 'package:store_app/store_app/checkout/views/shipping_info_view.dart';

class ShippingInfoPage extends StatelessWidget {
  const ShippingInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CheckoutBloc(CheckOutRepository()),
      child: const ShippingInfoView(),
    );
  }
}
