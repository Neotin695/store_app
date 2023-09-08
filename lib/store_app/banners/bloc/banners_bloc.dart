import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'banners_event.dart';
part 'banners_state.dart';

class BannersBloc extends Bloc<BannersEvent, BannersState> {
  BannersBloc() : super(BannersInitial()) {
    on<BannersEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
