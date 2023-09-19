import 'package:firebase_auth/firebase_auth.dart';
import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:store_app/core/services/common.dart';
import '../../../core/theme/colors/landk_colors.dart';
import '../../../core/tools/tools_widget.dart';
import '../routes/routes.dart';

class HomeLayout extends StatefulWidget {
  static Page page() => const MaterialPage(child: HomeLayout());
  const HomeLayout({super.key});

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  late FlowController<HomeState> controller;

  @override
  void initState() {
    controller = FlowController(HomeState.home);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: Common.scaffoldState,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.notifications_outlined),
        ),
        actions: [
          IconButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      body: _FlowPage(controller: controller),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              icon: const Icon(Icons.home),
              tooltip: 'home',
              label: trans(context).home),
          BottomNavigationBarItem(
              icon: const Icon(Icons.shopping_cart),
              tooltip: 'cart',
              label: trans(context).cart),
          BottomNavigationBarItem(
              icon: const Icon(Icons.settings),
              tooltip: 'menu',
              label: trans(context).settings),
          BottomNavigationBarItem(
              icon: const Icon(Icons.person),
              tooltip: 'Me',
              label: trans(context).profile),
        ],
        selectedItemColor: orange,
        unselectedItemColor: grey,
        currentIndex: controller.state.index,
        onTap: (index) {
          controller.update((_) =>
              HomeState.values.firstWhere((element) => element.index == index));
          setState(() {});
        },
      ),
    );
  }
}

class _FlowPage extends StatelessWidget {
  const _FlowPage({
    required this.controller,
  });

  final FlowController<HomeState> controller;

  @override
  Widget build(BuildContext context) {
    return FlowBuilder<HomeState>(
      controller: controller,
      onGeneratePages: onGenerateHomePage,
    );
  }
}
