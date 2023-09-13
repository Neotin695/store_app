import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app/store_app/auth/cubit/auth_cubit.dart';
import 'package:store_app/store_app/auth/repository/authentication_repository.dart';
import 'package:store_app/store_app/auth/views/auth_signup_view.dart';

class AuthSignUpPage extends StatelessWidget {
  const AuthSignUpPage({super.key, required this.authenticationRepository});
  final AuthenticationRepository authenticationRepository;
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: authenticationRepository,
      child: BlocProvider(
        create: (context) => AuthCubit(authenticationRepository),
        child: const AuthSignUpView(),
      ),
    );
  }
}
