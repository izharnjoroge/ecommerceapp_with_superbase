part of 'order_bloc_cubit.dart';

@immutable
sealed class OrderState {}

final class OrderInitial extends OrderState {}

final class OrdersLoading extends OrderState {}

final class OrdersLoaded extends OrderState {
  final List<OrderModel> orderModel;

  OrdersLoaded(this.orderModel);
}

final class OrdersError extends OrderState {
  final String error;

  OrdersError(this.error);
}
