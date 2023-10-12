import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

import '../../../core/constances/media_const.dart';
import '../../../core/theme/fonts/landk_fonts.dart';
import '../../../core/tools/tools_widget.dart';
import '../bloc/order_bloc.dart';
import '../repository/order_repository.dart';

class OrderPreviewView extends StatefulWidget {
  const OrderPreviewView({
    super.key,
    required this.order,
  });

  final Order order;

  @override
  State<OrderPreviewView> createState() => _OrderPreviewViewState();
}

final GlobalKey<ScaffoldState> customKey = GlobalKey();

class _OrderPreviewViewState extends State<OrderPreviewView> {
  late final OrderBloc bloc;
  @override
  void initState() {
    bloc = BlocProvider.of<OrderBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: customKey,
      appBar: AppBar(),
      body: BlocBuilder<OrderBloc, OrderState>(
        builder: (context, state) {
          return SingleChildScrollView(
            child: SizedBox(
              width: 99.w,
              child: Card(
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Text(
                          '${trans(context).orderNum}: #${widget.order.orderNum}',
                          style: h2,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                              '${trans(context).deliveryPrice}: ${widget.order.deliveryPrice}'),
                          Text(
                              '${trans(context).paymentMethod}: ${widget.order.paymentMethod}'),
                        ],
                      ),
                      vSpace(2),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            '${trans(context).location}: ${widget.order.addressInfo}',
                          ),
                          Text(
                            '${trans(context).orderState}: ${widget.order.delivered ? trans(context).delivered : trans(context).noDelivered}',
                          ),
                        ],
                      ),
                      vSpace(2),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            '${trans(context).date}: ${(DateFormat('yyyy-MM-DD HH:mm a').format(DateTime.fromMillisecondsSinceEpoch(widget.order.deliveryDate.millisecondsSinceEpoch)))}',
                          ),
                        ],
                      ),
                      ExpansionTile(
                        title: Text(trans(context).deliveryMan),
                        onExpansionChanged: (value) {
                          if (value) {
                            bloc.add(FetchDelegate(
                              id: widget.order.delegate,
                            ));
                            setState(() {});
                          }
                        },
                        children: [
                          ListTile(
                            leading: bloc.delegate.photoUrl.isEmpty
                                ? SvgPicture.asset(
                                    iPerson,
                                  )
                                : CachedNetworkImage(
                                    imageUrl: bloc.delegate.photoUrl,
                                    placeholder: (context, url) =>
                                        const CircularProgressIndicator(),
                                    errorWidget: (context, url, error) =>
                                        const Icon(Icons.error),
                                  ),
                            title: Text(bloc.delegate.name),
                            subtitle: Text(bloc.delegate.phoneNum),
                          )
                        ],
                      ),
                      ExpansionTile(
                        title: Text(trans(context).products),
                        onExpansionChanged: (value) {
                          if (value) {
                            bloc.add(FetchProduct(
                              ids: List<String>.from(widget
                                  .order.productQuantity
                                  .map((e) => e.productId)),
                            ));
                            setState(() {});
                          }
                        },
                        children: bloc.products.map((e) {
                          return ListTile(
                            leading: CachedNetworkImage(
                              imageUrl: e.coverUrl,
                              placeholder: (context, url) =>
                                  const CircularProgressIndicator(),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            ),
                            title:
                                Text(locale(context) ? e.titleAr : e.titleEn),
                            subtitle: Text(locale(context)
                                ? e.descriptionAr
                                : e.descriptionEn),
                            trailing: Text(
                              widget.order.productQuantity
                                  .firstWhere(
                                      (element) => element.productId == e.id)
                                  .toString(),
                              textAlign: TextAlign.center,
                            ),
                          );
                        }).toList(),
                      ),
                      vSpace(6),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
