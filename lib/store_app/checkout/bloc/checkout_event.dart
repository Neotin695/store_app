// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'checkout_bloc.dart';

sealed class CheckoutEvent extends Equatable {
  const CheckoutEvent();

  @override
  List<Object> get props => [];
}

class PlaceOrder extends CheckoutEvent {
  final Cart cart;
  final String cachType;
  const PlaceOrder({
    required this.cart,
    required this.cachType,
  });
}
