part of 'order_bloc.dart';

sealed class OrderState extends Equatable {
  const OrderState();

  @override
  List<Object> get props => [];
}

final class OrderInitial extends OrderState {}

class OrderLoadingState extends OrderState {}

class OrderSuccessState extends OrderState {}

class OrderFailureState extends OrderState {}
