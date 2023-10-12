import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../models/customer.dart';
import '../../../models/delegate.dart';
import '../../products/repository/model/porduct_model.dart';
import '../repository/order_repository.dart';

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  OrderBloc(
    this._orderRepository,
  ) : super(OrderInitial()) {
    on<_FetchAllOrders>(_fetchAllOrder);
    on<FetchDelegate>(_fetchDelegate);
    on<FetchOneOrder>(_fetchOneOrder);
    on<FetchProduct>(_fetchProduct);

    add(_FetchAllOrders());
  }

  final OrderRepository _orderRepository;
  late final StreamSubscription<List<Order>> _subscription;
  List<Order> orders = [];

  Order order = Order.empty();
  Customer customer = Customer.empty();
  List<Product> products = [];
  Delegate delegate = Delegate.empty();

  FutureOr<void> _fetchAllOrder(
      _FetchAllOrders event, Emitter<OrderState> emit) async {
    emit(OrderLoadingState());
    await emit.forEach(_orderRepository.fetchAllOrder(), onData: (data) {
      orders = data;
      return OrderSuccessState();
    }, onError: (
      _,
      __,
    ) {
      return OrderFailureState();
    });
  }

  FutureOr<void> _fetchDelegate(FetchDelegate event, emit) async {
    emit(OrderLoadingState());
    delegate = await _orderRepository.fetchDelegate(event.id);
    emit(OrderSuccessState());
  }

  FutureOr<void> _fetchOneOrder(FetchOneOrder event, emit) async {
    emit(OrderLoadingState());
    order = await _orderRepository.fetchOneOrder(event.id);
    emit(OrderSuccessState());
  }

  FutureOr<void> _fetchProduct(FetchProduct event, emit) async {
    emit(OrderLoadingState());
    products = await _orderRepository.fetchAllProducts(event.ids);
    if (products.isNotEmpty) {
      emit(OrderSuccessState());
    }
  }
}
