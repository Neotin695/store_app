import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app/store_app/banners/reppository/banners_repository.dart';
import 'package:store_app/store_app/banners/widget/banner_widget.dart';

import '../bloc/banners_bloc.dart';

class BannerPage extends StatelessWidget {
  const BannerPage({super.key, required this.bannerRepository});

  final BannerRepository bannerRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: bannerRepository,
      child: BlocProvider(
        create: (context) => BannersBloc(bannerRepository),
        child: const BannerWidget(),
      ),
    );
  }
}
