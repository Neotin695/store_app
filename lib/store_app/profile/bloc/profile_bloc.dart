import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:store_app/models/customer.dart';
import 'package:store_app/store_app/profile/repository/profile_repoisotyr.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitial()) {
    on<FetchUserData>((event, emit) async {
      emit(ProfileLoading());
      await ProfileRepo()
          .fetchUserData()
          .then((value) => emit(ProfileSuccess(value)));
    });

    add(FetchUserData());
  }
}
