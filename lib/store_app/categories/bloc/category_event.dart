// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'category_bloc.dart';

sealed class CategoryEvent extends Equatable {
  const CategoryEvent();

  @override
  List<Object> get props => [];
}

class _FetchAllBanners extends CategoryEvent {
  final List<Category> banners;
  const _FetchAllBanners({
    required this.banners,
  });
}
