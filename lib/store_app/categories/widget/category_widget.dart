import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:store_app/core/constances/media_const.dart';
import 'package:store_app/core/shared/empty_data.dart';
import 'package:store_app/core/theme/fonts/landk_fonts.dart';
import 'package:store_app/core/tools/tools_widget.dart';

import '../bloc/category_bloc.dart';

class CategoryWidget extends StatefulWidget {
  const CategoryWidget({super.key});

  @override
  State<CategoryWidget> createState() => _CategoryWidgetState();
}

class _CategoryWidgetState extends State<CategoryWidget> {
  late final CategoryBloc bloc;

  @override
  void initState() {
    bloc = BlocProvider.of<CategoryBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 3.w,
      ),
      child: BlocBuilder<CategoryBloc, CategoryState>(
        builder: (context, state) {
          if (state is CategoryLoading) return loadingWidget();
          if (state is CategoryFailure) {
            return empty();
          }

          if (state is CategoryLoaded) {
            return SizedBox(
              height: 15.h,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: state.category
                    .map(
                      (e) => Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CachedNetworkImage(
                            width: 20.w,
                            height: 10.h,
                            imageUrl: e.imageUrl,
                            fit: BoxFit.cover,
                            placeholder: (_, url) => loadingWidget(),
                          ),
                          vSpace(1),
                          Text(
                            locale(context) ? e.nameAr : e.nameEn,
                            style: bold,
                          )
                        ],
                      ),
                    )
                    .toList(),
              ),
            );
          }
          return empty();
        },
      ),
    );
  }
}
