import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/category_bloc.dart';
import '../reppository/category_repository.dart';
import '../widget/category_widget.dart';

class CategoryPage extends StatelessWidget {
  const CategoryPage({super.key, required this.categoryRepository});

  final CategoryRepository categoryRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: categoryRepository,
      child: BlocProvider(
        create: (context) => CategoryBloc(categoryRepository),
        child: const CategoryWidget(),
      ),
    );
  }
}
