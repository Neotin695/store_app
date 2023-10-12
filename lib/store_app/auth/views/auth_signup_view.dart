import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:formz/formz.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:sizer/sizer.dart';
import 'package:store_app/core/theme/colors/landk_colors.dart';
import 'package:store_app/core/theme/fonts/landk_fonts.dart';

import '../../../core/constances/media_const.dart';
import '../../../core/shared/offline_widget.dart';
import '../../../core/tools/tools_widget.dart';
import '../cubit/auth_cubit.dart';

class AuthSignUpView extends StatefulWidget {
  const AuthSignUpView({super.key});

  @override
  State<AuthSignUpView> createState() => _AuthSignUpViewState();
}

class _AuthSignUpViewState extends State<AuthSignUpView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state.status.isFailure) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Text(state.errorMessage.isEmpty
                      ? 'Authentication Failure'
                      : state.errorMessage),
                ),
              );
          }
        },
        child: OfflineWidget(
          child: SingleChildScrollView(
            child: SafeArea(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    vSpace(5),
                    SvgPicture.asset(iLogoOrange),
                    vSpace(5),
                    Text(
                      trans(context).welcome,
                      style: h3,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 3.w),
                      child: Text(
                        trans(context).welcomeMessage,
                        textAlign: TextAlign.center,
                        style: h6,
                      ),
                    ),
                    vSpace(5),
                    const _Name(),
                    vSpace(2),
                    const _Email(),
                    vSpace(2),
                    const _Password(),
                    vSpace(2),
                    const _PasswordConfirm(),
                    vSpace(2),
                    const _PhoneNum(),
                    vSpace(2),
                    const _SignInBtn(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _PhoneNum extends StatelessWidget {
  const _PhoneNum();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.w),
      child: InternationalPhoneNumberInput(
        formatInput: true,
        inputBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        onInputChanged: (PhoneNumber value) {
          context.read<AuthCubit>().phoneChanged(value.phoneNumber!);
        },
        selectorConfig: const SelectorConfig(
            selectorType: PhoneInputSelectorType.BOTTOM_SHEET),
      ),
    );
  }
}

class _SignInBtn extends StatelessWidget {
  const _SignInBtn();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        return ElevatedButton(
          onPressed: () => context.read<AuthCubit>().signUpWithCredentials(),
          style: ButtonStyle(
            alignment: Alignment.center,
            minimumSize: MaterialStateProperty.all(
              Size(90.w, 7.5.h),
            ),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            backgroundColor: MaterialStateProperty.all(orange),
          ),
          child: state.status == FormzSubmissionStatus.inProgress
              ? SizedBox(
                  width: 5.w,
                  height: 5.h,
                  child: const Center(child: CircularProgressIndicator()))
              : Text(
                  trans(context).createAccount,
                  style: btnFont,
                ),
        );
      },
    );
  }
}

class _Email extends StatelessWidget {
  const _Email();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      buildWhen: (previous, next) => previous.email != next.email,
      builder: (context, state) {
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 5.w),
          child: TextField(
            textDirection: directionField(context),
            key: const Key('email-input'),
            onChanged: (email) => context.read<AuthCubit>().emailChanged(email),
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.email),
              labelText: trans(context).email,
              errorText:
                  state.email.displayError != null ? 'invalid email' : null,
            ),
          ),
        );
      },
    );
  }

  TextDirection directionField(BuildContext context) =>
      locale(context) ? TextDirection.rtl : TextDirection.ltr;
}

class _Name extends StatelessWidget {
  const _Name();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      buildWhen: (previous, next) => previous.name != next.name,
      builder: (context, state) {
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 5.w),
          child: TextField(
            textDirection: directionField(context),
            key: const Key('email-input'),
            onChanged: (email) => context.read<AuthCubit>().nameChanged(email),
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.person),
              labelText: trans(context).fullName,
              errorText:
                  state.email.displayError != null ? 'invalid name' : null,
            ),
          ),
        );
      },
    );
  }

  TextDirection directionField(BuildContext context) =>
      locale(context) ? TextDirection.rtl : TextDirection.ltr;
}

class _Password extends StatelessWidget {
  const _Password();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      buildWhen: (previous, next) => previous.password != next.password,
      builder: (context, state) {
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 5.w),
          child: TextField(
            keyboardType: TextInputType.visiblePassword,
            key: const Key('password-input'),
            onChanged: (password) =>
                context.read<AuthCubit>().passwordChanged(password),
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.password),
              labelText: trans(context).password,
              errorText: state.password.displayError != null
                  ? 'invalid password'
                  : null,
            ),
          ),
        );
      },
    );
  }
}

class _PasswordConfirm extends StatelessWidget {
  const _PasswordConfirm();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      buildWhen: (previous, next) =>
          previous.confirmedPassword != next.confirmedPassword,
      builder: (context, state) {
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 5.w),
          child: TextField(
            keyboardType: TextInputType.visiblePassword,
            key: const Key('password-input'),
            onChanged: (password) =>
                context.read<AuthCubit>().confirmedPasswordChanged(password),
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.password),
              labelText: trans(context).confirmPassword,
              errorText: state.confirmedPassword.displayError != null
                  ? 'password not match'
                  : null,
            ),
          ),
        );
      },
    );
  }
}
