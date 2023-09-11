// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'banners_bloc.dart';

sealed class BannersEvent extends Equatable {
  const BannersEvent();

  @override
  List<Object> get props => [];
}

class _FetchAllBanners extends BannersEvent {
  final List<Banner> banners;
  const _FetchAllBanners({
    required this.banners,
  });
}
