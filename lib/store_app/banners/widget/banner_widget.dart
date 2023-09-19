import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:store_app/core/tools/tools_widget.dart';
import 'package:store_app/store_app/banners/bloc/banners_bloc.dart';

class BannerWidget extends StatefulWidget {
  const BannerWidget({super.key});

  @override
  State<BannerWidget> createState() => _BannerWidgetState();
}

class _BannerWidgetState extends State<BannerWidget> {
  late final BannersBloc bloc;

  @override
  void initState() {
    bloc = BlocProvider.of<BannersBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 2.h),
      child: BlocBuilder<BannersBloc, BannersState>(
        builder: (context, state) {
          if (state is BannersLoading) return loadingWidget();
          if (state is BannersFailure) {
            return empty();
          }

          if (state is BannersLoaded) {
            return CarouselSlider(
              items: state.banners
                  .map(
                    (e) => CachedNetworkImage(
                      imageUrl: e.photoUrl,
                      fit: BoxFit.cover,
                      placeholder: (_, url) => loadingWidget(),
                    ),
                  )
                  .toList(),
              options: CarouselOptions(
                aspectRatio: 25 / 10,
                viewportFraction: 1,
                autoPlay: true,
              ),
            );
          }
          return empty();
        },
      ),
    );
  }
}
