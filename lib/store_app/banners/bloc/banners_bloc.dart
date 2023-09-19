import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../reppository/banners_repository.dart';

part 'banners_event.dart';
part 'banners_state.dart';

class BannersBloc extends Bloc<BannersEvent, BannersState> {
  BannersBloc(this._bannerRepository) : super(BannersInitial()) {
    on<_FetchAllBanners>(_fetchAllBanners);

    _subscription = _bannerRepository.fetchAllBanners().listen((event) {
      add(_FetchAllBanners(banners: event));
    });
  }

  late final StreamSubscription<List<Banner>> _subscription;

  final BannerRepository _bannerRepository;

  @override
  Future close() {
    _subscription.cancel();
    return super.close();
  }

  FutureOr<void> _fetchAllBanners(_FetchAllBanners event, emit) {
    emit(BannersLoading());
    if (event.banners.isNotEmpty) {
      emit(BannersLoaded(banners: event.banners));
    } else {
      emit(BannersFailure());
    }
  }
}
