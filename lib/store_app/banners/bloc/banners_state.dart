part of 'banners_bloc.dart';

sealed class BannersState extends Equatable {
  const BannersState();
  
  @override
  List<Object> get props => [];
}

final class BannersInitial extends BannersState {}
