import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app/store_app/store/bloc/store_bloc.dart';
import 'package:store_app/store_app/store/repository/src/store_repository.dart';
import 'package:store_app/store_app/store/view/sotre_view.dart';

class StorePage extends StatelessWidget {
  static Page page() => MaterialPage(
          child: StorePage(
        storeRepository: StoreRepository(),
      ));
  const StorePage({super.key, required this.storeRepository});

  final StoreRepository storeRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: storeRepository,
      child: BlocProvider(
        create: (context) => StoreBloc(storeRepository),
        child: const StoreView(),
      ),
    );
  }
}
