import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app/store_app/store/repository/src/models/category.dart';
import 'package:store_app/store_app/store/repository/src/models/store.dart';
import 'package:store_app/store_app/store/repository/src/store_repository.dart';

import '../bloc/store_bloc.dart';
import 'store_view.dart';

class StorePage extends StatelessWidget {
  const StorePage(
      {super.key,
      required this.storeRepository,
      required this.store,
      required this.category});

  final Store store;
  final StoreCategory category;

  final StoreRepository storeRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: storeRepository,
      child: BlocProvider(
        create: (context) => StoreBloc(storeRepository)
          ..add(FetchAllProductsOfStore(storeId: store.id)),
        child: StoreView(store: store, category: category),
      ),
    );
  }
}
