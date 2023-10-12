// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'order_bloc.dart';

sealed class OrderEvent extends Equatable {
  const OrderEvent();

  @override
  List<Object> get props => [];
}

class _FetchAllOrders extends OrderEvent {}

class FetchOneOrder extends OrderEvent {
  final String id;
  const FetchOneOrder({
    required this.id,
  });
}

class FetchDelegate extends OrderEvent {
  final String id;
  const FetchDelegate({
    required this.id,
  });
}

class FetchProduct extends OrderEvent {
  final List<String> ids;
  const FetchProduct({
    required this.ids,
  });
}
