part of 'banners_bloc.dart';

sealed class BannersState extends Equatable {
  const BannersState();

  @override
  List<Object> get props => [];
}

final class BannersInitial extends BannersState {}

final class BannersLoading extends BannersState {}

final class BannersLoaded extends BannersState {
  final List<Banner> banners;

  const BannersLoaded({required this.banners});
}

final class BannersFailure extends BannersState {}
