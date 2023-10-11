import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:store_app/core/tools/tools_widget.dart';
import 'package:store_app/store_app/checkout/bloc/checkout_bloc.dart';
import 'package:store_app/store_app/checkout/views/pay_page.dart';

import '../../../core/shared/txt_field.dart';
import '../../../core/theme/colors/landk_colors.dart';
import '../../../core/theme/fonts/landk_fonts.dart';

class ShippingInfoView extends StatefulWidget {
  const ShippingInfoView({super.key});

  @override
  State<ShippingInfoView> createState() => _ShippingInfoViewState();
}

class _ShippingInfoViewState extends State<ShippingInfoView> {
  late final CheckoutBloc bloc;
  @override
  void initState() {
    bloc = BlocProvider.of<CheckoutBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              vSpace(5),
              Text(
                trans(context).shippingInfo,
                style: h2,
              ),
              vSpace(10),
              TxtField(
                cn: bloc.city,
                label: trans(context).city,
              ),
              TxtField(
                cn: bloc.addressLine,
                label: trans(context).addressLine,
              ),
              vSpace(5),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.w),
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => const PayPage()));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: orange,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    minimumSize: Size(100.w, 7.h),
                  ),
                  label: Text(
                    trans(context).pay,
                    style: h4.copyWith(color: black),
                  ),
                  icon: Icon(
                    Icons.payment,
                    color: black,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
