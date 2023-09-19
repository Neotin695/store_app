import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app/core/tools/tools_widget.dart';
import 'package:store_app/store_app/store/bloc/store_bloc.dart';
import 'package:store_app/store_app/store/repository/src/models/store.dart';
import 'package:store_app/store_app/store/repository/src/store_repository.dart';
import 'package:store_app/store_app/store/widget/store_item.dart';

class ShowAllStoresPage extends StatefulWidget {
  const ShowAllStoresPage({super.key, required this.stores});
  final List<Store> stores;
  @override
  State<ShowAllStoresPage> createState() => _StoreViewState();
}

class _StoreViewState extends State<ShowAllStoresPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => StoreBloc(StoreRepository()),
      child: Scaffold(
        appBar: AppBar(
          title: Text(trans(context).store),
          centerTitle: true,
        ),
        body: ListView(
          shrinkWrap: true,
          children: widget.stores.map(
            (e) {
              return StoreItem(store: e);
            },
          ).toList(),
        ),
      ),
    );
  }
}
