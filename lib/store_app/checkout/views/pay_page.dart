import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app/store_app/checkout/bloc/checkout_bloc.dart';
import 'package:store_app/store_app/checkout/views/pay_view.dart';

import '../repository/src/checkout_repository.dart';

class PayPage extends StatelessWidget {
  const PayPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CheckoutBloc(CheckOutRepository()),
      child: const PayView(),
    );
  }
}
