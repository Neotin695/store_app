import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app/store_app/profile/bloc/profile_bloc.dart';
import 'package:store_app/store_app/profile/repository/profile_repoisotyr.dart';

class ProfilePage extends StatelessWidget {
  static Page page() =>
      MaterialPage(child: ProfilePage(profileRepository: ProfileRepository()));
  const ProfilePage({super.key, required this.profileRepository});

  final ProfileRepository profileRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: profileRepository,
      child: BlocProvider(
        create: (context) => ProfileBloc(),
        child: Container(),
      ),
    );
  }
}
