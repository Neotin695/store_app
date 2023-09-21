import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:moyasar/moyasar.dart';
import 'package:store_app/core/services/common.dart';

import '../../../core/constances/logic_const.dart';

class PayView extends StatefulWidget {
  const PayView({super.key});

  @override
  State<PayView> createState() => _PayViewState();
}

class _PayViewState extends State<PayView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: CreditCard(
          config: PaymentConfig(
            publishableApiKey: LogicConst.moyasarKey,
            amount: int.parse('${Common.totalPrice}0'), // SAR 257.58
            description: 'order #1324',
            metadata: {'size': '250g'},
          ),
          onPaymentResult: (result) {
            if (result is PaymentResponse) {
              switch (result.status) {
                case PaymentStatus.paid:
                  // handle success.
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
    );
  }
}
