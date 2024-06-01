import 'package:bloc/bloc.dart';
import 'package:ecommerceapp/models/order_model.dart';
import 'package:ecommerceapp/repos/orderRepo/order_repo.dart';
import 'package:meta/meta.dart';

part 'order_bloc_state.dart';

class OrderCubit extends Cubit<OrderState> {
  final OrderRepo orderRepo;
  OrderCubit(this.orderRepo) : super(OrderInitial());

  void getOrders() async {
    emit(OrdersLoading());
    try {
      List<OrderModel> orderModel = await orderRepo.getOrders();
      emit(OrdersLoaded(orderModel));
    } catch (e) {
      emit(OrdersError(e.toString()));
    }
  }
}
