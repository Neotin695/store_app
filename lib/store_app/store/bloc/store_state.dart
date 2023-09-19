part of 'store_bloc.dart';

sealed class StoreState extends Equatable {
  const StoreState();

  @override
  List<Object> get props => [];
}

final class StoreInitial extends StoreState {}

final class StoreLoading extends StoreState {}

final class StoreLoaded extends StoreState {
  final List<Store> stores;

  const StoreLoaded({required this.stores});
}

final class StoreFailure extends StoreState {}

final class StoreSuccess extends StoreState {}

final class ProductLoaded extends StoreState {
  final List<Product> products;

  const ProductLoaded({required this.products});
}
