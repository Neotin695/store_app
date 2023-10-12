import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:store_app/store_app/cart/repository/src/model/cart.dart';
import 'package:store_app/store_app/checkout/repository/src/checkout_repository.dart';

part 'checkout_event.dart';
part 'checkout_state.dart';

class CheckoutBloc extends Bloc<CheckoutEvent, CheckoutState> {
  CheckoutBloc(this.repository) : super(CheckoutInitial()) {
    on<PlaceOrder>(
      (PlaceOrder event, emit) async {
        emit(CheckoutLoading());
       
        await repository.placeOrder(event.cart,event.cachType).then((value) {
          emit(CheckoutSuccess());
        });
      },
    );
  }
  final CheckOutRepository repository;

  final TextEditingController city = TextEditingController();
  final TextEditingController build = TextEditingController();
  final TextEditingController addressLine = TextEditingController();
}
