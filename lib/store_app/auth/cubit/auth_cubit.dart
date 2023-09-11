import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:formz/formz.dart';
import 'package:geocoding/geocoding.dart';
import 'package:location/location.dart';

import '../../../core/services/form_input/form_input.dart';
import '../../../core/services/form_input/src/address.dart';
import '../../../core/services/form_input/src/name.dart';
import '../../../core/services/form_input/src/phone.dart';
import '../../../core/tools/tools_widget.dart';
import '../../../models/model.dart';
import '../../maps/map_repository/map_repository.dart';
import '../../maps/view/map_page.dart';
import '../repository/authentication_repository.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this._authenticationRepository) : super(const AuthState());

  final AuthenticationRepository _authenticationRepository;

  final PageController controller = PageController();
  LocationData? locationData;

  Map<String, dynamic> placeDatals = {};
  String? logoPath;
  String? coverPath;
  String selectedCategory = '';

  Future<void> getCurrentLocation(BuildContext context) async {
    emit(state.copyWith(
        status: FormzSubmissionStatus.inProgress, errorMessage: 'loc'));
    locationData =
        await MapRepository().getCurrentLocation().then((event) async {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        event!.latitude!,
        event.longitude!,
      );
      if (placemarks.isNotEmpty) {
        placeDatals = {
          'name': placemarks[0].subAdministrativeArea!,
          'street': placemarks[0].street!,
          'postalcode': placemarks[0].postalCode!,
        };
      }

      return event;
    });

    if (locationData == null) {
      emit(state.copyWith(
          // ignore: use_build_context_synchronously
          errorMessage: trans(context).errorCurrentLocation,
          status: FormzSubmissionStatus.failure));
    }

    emit(state.copyWith(status: FormzSubmissionStatus.success));
  }

  Future<void> setLocationOnMap(BuildContext context) async {
    locationData = await Navigator.push<LocationData>(
      context,
      MaterialPageRoute(
        builder: (_) => MapPage(
          mapRepository: MapRepository(),
          state: 'locate',
        ),
      ),
    ).then((value) async {
      emit(state.copyWith(status: FormzSubmissionStatus.success));
      return value;
    });

    if (locationData == null) {
      emit(state.copyWith(
          errorMessage: trans(context).errorMapLocation,
          status: FormzSubmissionStatus.failure));
    }
  }

  AddressInfo _initAddress() {
    return AddressInfo(
        longitude: locationData!.longitude!,
        latitude: locationData!.latitude!,
        specialMarque: state.address.value);
  }

  void emailChanged(String value) {
    final email = Email.dirty(value);

    emit(
      state.copyWith(
        email: email,
        isValid: Formz.validate([
          email,
          state.password,
        ]),
      ),
    );
  }

  void emailChangedSignUp(String value) {
    final email = Email.dirty(value);

    emit(
      state.copyWith(
        email: email,
        isValid: Formz.validate([
          email,
          state.password,
          state.fullName,
          state.name,
          state.address,
          state.phone
        ]),
      ),
    );
  }

  void nameChanged(String value) {
    final name = Name.dirty(value);
    if (!isClosed) {
      emit(
        state.copyWith(
          name: name,
          isValid: Formz.validate([
            state.email,
            state.password,
            state.fullName,
            name,
            state.address,
            state.phone
          ]),
        ),
      );
    }
  }

  void addressChanged(String value) {
    final address = Address.dirty(value);
    if (!isClosed) {
      emit(
        state.copyWith(
          address: address,
          isValid: Formz.validate([
            state.email,
            state.password,
            state.fullName,
            state.name,
            address,
            state.phone
          ]),
        ),
      );
    }
  }

  void phoneChanged(String value) {
    final phone = Phone.dirty(value);
    if (!isClosed) {
      emit(
        state.copyWith(
          phone: phone,
          isValid: Formz.validate([
            state.email,
            state.password,
            state.fullName,
            state.name,
            state.address,
            phone
          ]),
        ),
      );
    }
  }

  void fullNameChanged(String value) {
    final fullName = Name.dirty(value);
    if (!isClosed) {
      emit(
        state.copyWith(
          fullName: fullName,
          isValid: Formz.validate([
            state.email,
            state.password,
            fullName,
            state.name,
            state.address,
            state.phone
          ]),
        ),
      );
    }
  }

  void passwordChanged(String value) {
    final password = Password.dirty(value);

    emit(
      state.copyWith(
        password: password,
        isValid: Formz.validate([
          state.email,
          password,
        ]),
      ),
    );
  }

  void passwordChangedSignUp(String value) {
    final password = Password.dirty(value);

    emit(
      state.copyWith(
        password: password,
        isValid: Formz.validate([
          state.email,
          password,
          state.fullName,
          state.name,
          state.address,
          state.phone
        ]),
      ),
    );
  }

  void confirmedPasswordChanged(String value) {
    final conPassword =
        ConfirmedPassword.dirty(password: state.password.value, value: value);

    emit(
      state.copyWith(
        confirmedPassword: conPassword,
        isValid: Formz.validate([
          state.email,
          state.password,
          conPassword,
          state.fullName,
          state.name,
          state.address,
          state.phone
        ]),
      ),
    );
  }

  Future<void> logInWithCredentials() async {
    if (!state.isValid) return;
    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
    try {
      await _authenticationRepository.signInWithEmailAndPassword(
        email: state.email.value,
        password: state.password.value,
      );
      emit(state.copyWith(status: FormzSubmissionStatus.success));
    } on LogInWithEmailAndPasswordFailure catch (e) {
      emit(
        state.copyWith(
          errorMessage: e.message,
          status: FormzSubmissionStatus.failure,
        ),
      );
    } catch (_) {
      emit(state.copyWith(status: FormzSubmissionStatus.failure));
    }
  }
}
