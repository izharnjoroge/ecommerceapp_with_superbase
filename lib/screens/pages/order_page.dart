import 'dart:developer';

import 'package:ecommerceapp/models/order_model.dart';
import 'package:ecommerceapp/screens/widgets/item_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../blocs/orderBloc/order_bloc_cubit.dart';

class MyOrders extends StatefulWidget {
  const MyOrders({super.key});

  @override
  State<MyOrders> createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {
  @override
  void initState() {
    super.initState();
    context.read<OrderCubit>().getOrders();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: const Text(
          'My Orders',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onPressed: () => Get.back(),
        ),
      ),
      body: BlocBuilder<OrderCubit, OrderState>(
        builder: (context, state) {
          if (state is OrdersLoading) {
            return const Center(
              child: CircularProgressIndicator(color: Colors.purple),
            );
          } else if (state is OrdersLoaded) {
            if (state.orderModel.isNotEmpty) {
              state.orderModel
                  .sort((a, b) => b.created_at.compareTo(a.created_at));
              return ListView.builder(
                itemCount: state.orderModel.length,
                itemBuilder: (context, index) {
                  final order = state.orderModel[index];
                  return OrderTile(order: order);
                },
              );
            } else {
              return const Center(child: Text('Nothing Here'));
            }
          } else if (state is OrdersError) {
            log('${state.error}');
            return const Center(
              child: Text('Something went wrong'),
            );
          } else {
            return const Center(
              child: Text('Something went wrong'),
            );
          }
        },
      ),
    );
  }
}

class OrderTile extends StatelessWidget {
  final OrderModel order;

  const OrderTile({Key? key, required this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Card(
        elevation: 4.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: ListTile(
          contentPadding:
              const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
          title: Text(
            'Amount: KSH ${order.amount}\nDate: ${formatDate(order.created_at)}',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          trailing: order.completed
              ? const Icon(Icons.check_circle, color: Colors.green)
              : const Icon(Icons.pending, color: Colors.purple),
          onTap: () {
            showModalBottomSheet(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
              ),
              clipBehavior: Clip.antiAlias,
              context: context,
              builder: (context) => OrderDetailsModal(order: order),
            );
          },
        ),
      ),
    );
  }

  String formatDate(DateTime date) {
    final day = DateFormat('EEEE').format(date);
    final dayOfMonth = DateFormat('d').format(date);
    final month = DateFormat('MMMM').format(date);
    final time = DateFormat('HH:mm').format(date);
    final suffix = getDayOfMonthSuffix(int.parse(dayOfMonth));
    return 'On $day $dayOfMonth$suffix $month at $time';
  }

  String getDayOfMonthSuffix(int day) {
    if (day >= 11 && day <= 13) {
      return 'th';
    }
    switch (day % 10) {
      case 1:
        return 'st';
      case 2:
        return 'nd';
      case 3:
        return 'rd';
      default:
        return 'th';
    }
  }
}

class OrderDetailsModal extends StatelessWidget {
  final OrderModel order;

  const OrderDetailsModal({Key? key, required this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Total Amount: \KSH ${order.amount}',
            style: const TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
          ),
          const SizedBox(height: 10),
          const Text(
            'Items:',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: ListView.builder(
                itemCount: order.items.length,
                padding: const EdgeInsets.all(5),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () => Get.to(
                        () => ItemDetails(itemModel: order.items[index])),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15)),
                      child: ListTile(
                        leading: SizedBox(
                            height: 50,
                            width: 50,
                            child: SvgPicture.network(
                              order.items[index].image,
                              fit: BoxFit.cover,
                            )),
                        title: Text(order.items[index].name),
                        subtitle: Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  order.items[index].amount.toString(),
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ],
                        ),
                        // trailing: IconButton(
                        //     onPressed: () {
                        //       context
                        //           .read<CartProvider>()
                        //           .removeFromCart(order.items[index]);
                        //     },
                        //     icon: const Icon(Icons.delete)),
                      ),
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
