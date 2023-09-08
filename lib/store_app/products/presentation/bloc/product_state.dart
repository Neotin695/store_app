part of 'product_bloc.dart';

sealed class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object> get props => [];
}

final class ProductInitial extends ProductState {}

final class ProductsLoading extends ProductState {}

final class ProductsLoaded extends ProductState {
  final List<ProductEntity> products;

  const ProductsLoaded({required this.products});
}

final class ProductsFailure extends ProductState {
  final String message;

  const ProductsFailure({required this.message});
}
