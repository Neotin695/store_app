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

    _subscription = _orderRepository.fetchAllOrder().listen((event) {
      add(_FetchAllOrders(orders: event));
    });
  }

  final OrderRepository _orderRepository;
  late final StreamSubscription<List<Order>> _subscription;
  List<Order> orders = [];

  Order order = Order.empty();
  Customer customer = Customer.empty();
  List<Product> products = [];
  Delegate delegate = Delegate.empty();

  @override
  Future<void> close() {
    _subscription.cancel();
    return super.close();
  }

  FutureOr<void> _fetchAllOrder(_FetchAllOrders event, emit) {
    emit(OrderLoadingState());
    orders = event.orders;
    if (orders.isNotEmpty) {
      emit(OrderSuccessState());
    }
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
