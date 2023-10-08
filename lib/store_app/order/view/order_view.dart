import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constances/media_const.dart';
import '../../../core/shared/empty_data.dart';
import '../bloc/order_bloc.dart';
import '../widget/new_orders.dart';

class OrderView extends StatefulWidget {
  const OrderView({super.key});

  @override
  State<OrderView> createState() => _OrderViewState();
}

late TabController tabcontroller;

class _OrderViewState extends State<OrderView> {
  late final OrderBloc bloc;

  @override
  void initState() {
    bloc = context.read<OrderBloc>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder<OrderBloc, OrderState>(
        builder: (context, state) {
          if (state is OrderSuccessState) {
            return NewOrders(
              orders: bloc.orders,
            );
          }
          return EmptyData(
            assetIcon: iEmpty,
            title: 'no Orders',
          );
        },
      ),
    );
  }
}
