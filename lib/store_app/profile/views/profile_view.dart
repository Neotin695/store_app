import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:store_app/core/constances/media_const.dart';
import 'package:store_app/core/services/common.dart';
import 'package:store_app/core/theme/fonts/landk_fonts.dart';
import 'package:store_app/core/tools/tools_widget.dart';
import 'package:store_app/store_app/order/repository/src/order_repository.dart';
import 'package:store_app/store_app/order/view/order_page.dart';
import 'package:store_app/store_app/profile/bloc/profile_bloc.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  late final ProfileBloc bloc;
  @override
  void initState() {
    bloc = BlocProvider.of<ProfileBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            if (state is ProfileLoading) return loadingWidget();
            if (state is ProfileSuccess) {
              return Column(
                children: [
                  Center(
                    child: CircleAvatar(
                      foregroundImage: AssetImage(iPersonPng),
                      radius: 30.sp,
                    ),
                  ),
                  Text(
                    state.customer.name,
                    style: h4,
                  ),
                  Text(state.customer.email),
                  Text(state.customer.phoneNum),
                  const Divider(),
                  ListTile(
                    title: Text(trans(context).order),
                    onTap: () {
                      Navigator.push(
                          Common.scaffoldState.currentContext!,
                          MaterialPageRoute(
                              builder: (context) => OrderPage(
                                  orderRepository: OrderRepository())));
                    },
                    trailing: const Icon(Icons.arrow_forward_ios),
                  )
                ],
              );
            }
            return empty();
          },
        ),
      ),
    );
  }
}
