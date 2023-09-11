import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:store_app/store_app/products/repository/model/porduct_model.dart';
import 'package:store_app/store_app/store/repository/src/models/store.dart';
import 'package:store_app/store_app/store/repository/src/store_repository.dart';

part 'store_event.dart';
part 'store_state.dart';

class StoreBloc extends Bloc<StoreEvent, StoreState> {
  StoreBloc(this._repository) : super(StoreInitial()) {
    on<_FetchAllStores>(_fetchAllStores);
    on<FetchAllProductsOfStore>(_fetchAlllProductsOfStore);
    on<AddReview>((AddReview event, emit) {});

    _storeSubscription = _repository.fetchStore().listen((event) {
      add(_FetchAllStores(stores: event));
    });
  }

  FutureOr<void> _fetchAlllProductsOfStore(
      FetchAllProductsOfStore event, Emitter<StoreState> emit) {
    emit(StoreLoading());
    emit.forEach(_repository.fetchProductOfStore(event.storeId),
        onData: (data) {
      return ProductLoaded(products: data);
    });
  }

  FutureOr<void> _fetchAllStores(_FetchAllStores event, emit) {
    emit(StoreLoading());
    if (event.stores.isNotEmpty) {
      emit(StoreLoaded(stores: event.stores));
    }
  }

  @override
  Future close() {
    _storeSubscription.cancel();
    _productSubscription.cancel();
    return super.close();
  }

  late final StreamSubscription<List<Store>> _storeSubscription;
  late final StreamSubscription<List<Product>> _productSubscription;
  final StoreRepository _repository;
}
