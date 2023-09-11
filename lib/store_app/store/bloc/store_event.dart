// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'store_bloc.dart';

sealed class StoreEvent extends Equatable {
  const StoreEvent();

  @override
  List<Object> get props => [];
}

class _FetchAllStores extends StoreEvent {
  final List<Store> stores;
  const _FetchAllStores({
    required this.stores,
  });
}

class FetchAllProductsOfStore extends StoreEvent {
  final String storeId;
  const FetchAllProductsOfStore({
    required this.storeId,
  });
}

class AddReview extends StoreEvent {}
