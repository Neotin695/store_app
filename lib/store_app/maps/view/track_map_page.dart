import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/map_bloc.dart';
import '../map_repository/src/map_repository.dart';
import 'tack_map_view.dart';

class TrackMapPage extends StatelessWidget {
  const TrackMapPage(
      {super.key, required this.mapRepository, required this.delegate});

  final MapRepository mapRepository;
  final String delegate;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: mapRepository,
      child: BlocProvider(
        create: (context) => MapBloc(mapRepository),
        child: TrackMapView(
          delegate: delegate,
        ),
      ),
    );
  }
}
