import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app/store_app/store/bloc/store_bloc.dart';
import 'package:store_app/store_app/store/repository/src/store_repository.dart';
import 'package:store_app/store_app/store/view/stores_view.dart';

class StoresPage extends StatelessWidget {
  static Page page() => MaterialPage(
          child: StoresPage(
        storeRepository: StoreRepository(),
      ));
  const StoresPage({super.key, required this.storeRepository});

  final StoreRepository storeRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: storeRepository,
      child: BlocProvider(
        create: (context) => StoreBloc(storeRepository)..add(FetchAllStores()),
        child: const StoresView(),
      ),
    );
  }
}
