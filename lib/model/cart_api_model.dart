import 'package:cart_coral_machinetest/model/fakestore_api.model.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

class CartApiModel {
  final FakeStoreApiModel product;
  RxInt quantity;

  CartApiModel({
    required this.product,
    int quantity = 1,
  }) : quantity = quantity.obs;
}
