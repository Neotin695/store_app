import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:formz/formz.dart';
import 'package:store_app/models/customer.dart';
import 'package:store_app/models/model.dart';

import '../../../core/services/form_input/form_input.dart';
import '../../../core/services/form_input/src/address.dart';
import '../../../core/services/form_input/src/name.dart';
import '../../../core/services/form_input/src/phone.dart';
import '../repository/authentication_repository.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this._authenticationRepository) : super(const AuthState());

  final AuthenticationRepository _authenticationRepository;

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

  void nameChanged(String value) {
    final name = Name.dirty(value);

    emit(
      state.copyWith(
        name: name,
        isValid: Formz.validate([
          name,
          state.email,
          state.password,
        ]),
      ),
    );
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

  void phoneChanged(String value) {
    final phone = Phone.dirty(value);
    emit(state.copyWith(
        phone: phone,
        isValid: Formz.validate([
          state.email,
          state.password,
          state.confirmedPassword,
          phone,
        ])));
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
          state.phone,
          conPassword,
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

  Future<void> signUpWithCredentials() async {
    if (!state.isValid) return;
    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
    try {
      await _authenticationRepository
          .signUpWithEmailAndPassowrd(
        email: state.email.value,
        password: state.password.value,
      )
          .then((value) async {
        await FirebaseFirestore.instance
            .collection('customers')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .set(Customer(
                id: FirebaseAuth.instance.currentUser!.uid,
                active: true,
                name: state.name.value,
                photoUrl: '',
                email: state.email.value,
                isEmailVerified: false,
                phoneNum: state.phone.value,
                location: AddressInfo.empty(),
                token: '',
                orders: const []).toMap())
            .then((value) =>
                emit(state.copyWith(status: FormzSubmissionStatus.success)));
      });
    } on SignUpWithEmailAndPasswordFailure catch (e) {
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
