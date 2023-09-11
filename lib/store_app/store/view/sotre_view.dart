import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app/core/constances/media_const.dart';
import 'package:store_app/core/shared/empty_data.dart';
import 'package:store_app/core/tools/tools_widget.dart';
import 'package:store_app/store_app/store/bloc/store_bloc.dart';
import 'package:store_app/store_app/store/widget/store_item.dart';

class StoreView extends StatefulWidget {
  const StoreView({super.key});

  @override
  State<StoreView> createState() => _StoreViewState();
}

class _StoreViewState extends State<StoreView> {
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
          return Expanded(
            child: ListView(
              children: state.stores.map((e) {
                return StoreItem(store: e);
              }).toList(),
            ),
          );
        }
        return empty();
      },
    );
  }
}
