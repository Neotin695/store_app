import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:store_app/store_app/products/repository/model/porduct_model.dart';
import 'package:store_app/store_app/store/repository/src/models/category.dart';
import 'package:store_app/store_app/store/repository/src/models/store.dart';
import 'package:store_app/store_app/store/repository/src/store_repository.dart';

part 'store_event.dart';
part 'store_state.dart';

class StoreBloc extends Bloc<StoreEvent, StoreState> {
  StoreBloc(this._repository) : super(StoreInitial()) {
    on<_FetchAllStores>(_fetchAllStores);
    on<FetchAllProductsOfStore>(_fetchAlllProductsOfStore);
    on<AddReview>((AddReview event, emit) {});
    on<PopulateStoreCategory>(_populateStoreCategory);
    add(_FetchAllStores());
  }

  FutureOr<void> _populateStoreCategory(
      PopulateStoreCategory event, emit) async {
    emit(StoreLoading());
    await _repository.populateStoreCategory(event.categoryId).then(
      (value) {
        storeCategory = value;
        emit(StoreLoaded(stores: store));
      },
    );
  }

  List<Store> store = [];

  FutureOr<void> _fetchAlllProductsOfStore(
      FetchAllProductsOfStore event, Emitter<StoreState> emit) async {
    emit(StoreLoading());
    await emit.forEach(_repository.fetchProductOfStore(event.storeId),
        onData: (data) {
      return ProductLoaded(products: data);
    });
  }

  StoreCategory storeCategory = StoreCategory.empty();

  FutureOr<void> _fetchAllStores(
      _FetchAllStores event, Emitter<StoreState> emit) async {
    emit(StoreLoading());
    await emit.forEach(_repository.fetchStore(), onData: (data) {
      store = data;
      return StoreLoaded(stores: data);
    });
  }

  final StoreRepository _repository;
}
