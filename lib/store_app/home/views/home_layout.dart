import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/constances/media_const.dart';
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

  double topPadding = 5;
  double leftPadding = 10;
  double centerPaddingLeft = 20;
  double centerPaddingRight = 20;
  double rightPadding = 10;
  double bottomPadding = 5;

  @override
  Widget build(BuildContext context) {
    String getTitleOfPage = switch (controller.state) {
      HomeState.home => trans(context).home,
      HomeState.menu => trans(context).settings,
    };
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.notifications_outlined),
        ),
        title: Text(getTitleOfPage),
        centerTitle: true,
        actions: [
          StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('stores')
                .doc(FirebaseAuth.instance.currentUser!.uid)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Switch(
                    value: (snapshot.data!.data())!['active'],
                    onChanged: (value) {
                      FirebaseFirestore.instance
                          .collection('stores')
                          .doc(FirebaseAuth.instance.currentUser!.uid)
                          .update({'active': value});
                    });
              }
              return empty();
            },
          )
        ],
      ),
      body: _FlowPage(controller: controller),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller.update((state) => HomeState.home);
          setState(() {});
        },
        child: SvgPicture.asset(
          iStors,
          colorFilter: ColorFilter.mode(white, BlendMode.srcIn),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: _bottomBar(),
    );
  }

  Widget _bottomBar() {
    return BottomAppBar(
      notchMargin: 6,
      shape: const CircularNotchedRectangle(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _bottomItem(iHome, HomeState.home,
              EdgeInsets.only(left: leftPadding, top: topPadding)),
          _bottomItem(
              iOrder,
              HomeState.menu,
              EdgeInsets.only(
                  right: locale(context) ? 0 : centerPaddingRight,
                  left: locale(context) ? centerPaddingLeft : 0,
                  top: topPadding)),
          _bottomItem(
              iProduct,
              HomeState.home,
              EdgeInsets.only(
                  right: locale(context) ? centerPaddingRight : 0,
                  left: locale(context) ? 0 : centerPaddingLeft,
                  top: topPadding)),
          _bottomItem(iMenu, HomeState.menu,
              EdgeInsets.only(right: rightPadding, top: topPadding)),
        ],
      ),
    );
  }

  Padding _bottomItem(icon, state, padding) {
    return Padding(
      padding: padding,
      child: IconButton(
        onPressed: () {
          controller.update((value) => state);

          setState(() {});
        },
        icon: SvgPicture.asset(
          icon,
          colorFilter: ColorFilter.mode(
              controller.state == state ? orange : black, BlendMode.srcIn),
        ),
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
