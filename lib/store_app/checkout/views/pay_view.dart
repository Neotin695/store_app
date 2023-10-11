import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moyasar/moyasar.dart';
import 'package:store_app/core/services/common.dart';
import 'package:store_app/store_app/checkout/bloc/checkout_bloc.dart';
import 'package:store_app/store_app/home/views/home_layout.dart';

import '../../../core/constances/logic_const.dart';

class PayView extends StatefulWidget {
  const PayView({super.key});

  @override
  State<PayView> createState() => _PayViewState();
}

class _PayViewState extends State<PayView> {
  late final CheckoutBloc bloc;
  @override
  void initState() {
    bloc = BlocProvider.of<CheckoutBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: BlocListener<CheckoutBloc, CheckoutState>(
          listener: (context, state) {
            if (state is CheckoutSuccess) {
              CoolAlert.show(
                  context: context,
                  type: CoolAlertType.success,
                  onConfirmBtnTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => const HomeLayout()));
                  });
            }
          },
          child: CreditCard(
            config: PaymentConfig(
              publishableApiKey: LogicConst.moyasarKey,
              amount: int.parse('${Common.totalCart.floor()}0'), // SAR 257.58
              description: 'order #1324',
              metadata: {'size': '250g'},
            ),
            onPaymentResult: (result) {
              if (result is PaymentResponse) {
                switch (result.status) {
                  case PaymentStatus.paid:
                    bloc.add(PlaceOrder(cart: Common.cart));
                    break;
                  case PaymentStatus.failed:
                    // handle failure.
                    break;
                  case PaymentStatus.initiated:
                  // TODO: Handle this case.
                  case PaymentStatus.authorized:
                  // TODO: Handle this case.
                  case PaymentStatus.captured:
                  // TODO: Handle this case.
                }
              }
            },
          ),
        ),
      ),
    );
  }
}
