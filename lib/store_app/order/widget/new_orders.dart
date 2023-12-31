import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constances/media_const.dart';
import '../../../core/shared/empty_data.dart';
import '../bloc/order_bloc.dart';
import '../repository/order_repository.dart';
import 'order_item.dart';

class NewOrders extends StatefulWidget {
  const NewOrders({super.key, required this.orders});

  final List<Order> orders;

  @override
  State<NewOrders> createState() => _NewOrdersState();
}

class _NewOrdersState extends State<NewOrders> {
  late final OrderBloc bloc;

  @override
  void initState() {
    bloc = context.read<OrderBloc>();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.orders.isNotEmpty
        ? ListView.builder(
            itemCount: widget.orders.length,
            itemBuilder: (context, index) {
              final order = widget.orders[index];
              return OrderItem(order: order);
            },
          )
        : EmptyData(
            assetIcon: iEmpty,
            title: 'No Order',
          );
  }
}
