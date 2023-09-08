// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'product_bloc.dart';

sealed class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object> get props => [];
}

class _FetchAllProducts extends ProductEvent {
  final List<ProductEntity> products;
  const _FetchAllProducts({
    required this.products,
  });
}

class AddToCart extends ProductEvent {}

class RemoveFromCart extends ProductEvent {}

class AddToWishlist extends ProductEvent {}

class RemoveFromWishlist extends ProductEvent {}
