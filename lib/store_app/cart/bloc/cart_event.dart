// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'cart_bloc.dart';

sealed class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

class _FetchAllCart extends CartEvent {}

class IncreaseQuantity extends CartEvent {
  final ProductQuantity count;
  const IncreaseQuantity({
    required this.count,
  });
}

class DecreaseQuantity extends CartEvent {
  final ProductQuantity count;
  const DecreaseQuantity({
    required this.count,
  });
}
class RemoveFromCart extends CartEvent {
  final ProductQuantity count;
  const RemoveFromCart({
    required this.count,
  });
}
