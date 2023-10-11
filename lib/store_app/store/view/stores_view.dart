import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app/core/constances/media_const.dart';
import 'package:store_app/core/shared/empty_data.dart';
import 'package:store_app/core/tools/tools_widget.dart';
import 'package:store_app/store_app/store/bloc/store_bloc.dart';
import 'package:store_app/store_app/store/view/show_all_stores_page.dart';
import 'package:store_app/store_app/store/widget/store_item.dart';

import '../../../core/services/common.dart';

class StoresView extends StatefulWidget {
  const StoresView({super.key});
  @override
  State<StoresView> createState() => _StoreViewState();
}

class _StoreViewState extends State<StoresView> {
  late final StoreBloc bloc;

  @override
  void initState() {
    bloc = BlocProvider.of<StoreBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StoreBloc, StoreState>(
      builder: (context, state) {
        if (state is StoreLoading) return loadingWidget();
        if (state is StoreFailure) {
          return EmptyData(assetIcon: iEmpty, title: 'title');
        }

        if (state is StoreLoaded) {
          return Column(
            children: [
              ListTile(
                title: Text(trans(context).store),
                trailing: TextButton(
                  onPressed: () {
                    Navigator.push(
                      Common.scaffoldState.currentContext!,
                      MaterialPageRoute(
                        builder: (_) => ShowAllStoresPage(
                          stores: state.stores,
                        ),
                      ),
                    );
                  },
                  child: Text(trans(context).showMore),
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: state.stores.length,
                itemBuilder: (context, index) {
                  final store = state.stores[index];
                  return StoreItem(store: store);
                },
              ),
            ],
          );
        }
        return empty();
      },
    );
  }
}
