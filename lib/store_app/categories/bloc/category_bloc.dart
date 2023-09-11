import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../reppository/category_repository.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  CategoryBloc(this._categoryRepository) : super(CategoryInitial()) {
    on<_FetchAllBanners>(_fetchAllBanners);

    _subscription = _categoryRepository.fetchAllCategories().listen((event) {
      add(_FetchAllBanners(banners: event));
    });
  }

  late final StreamSubscription<List<Category>> _subscription;

  final CategoryRepository _categoryRepository;

  @override
  Future close() {
    _subscription.cancel();
    return super.close();
  }

  FutureOr<void> _fetchAllBanners(_FetchAllBanners event, emit) {
    emit(CategoryLoading());
    if (event.banners.isNotEmpty) {
      emit(CategoryLoaded(category: event.banners));
    } else {
      emit(CategoryFailure());
    }
  }
}
