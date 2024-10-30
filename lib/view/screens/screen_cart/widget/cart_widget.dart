import 'package:cached_network_image/cached_network_image.dart';
import 'package:cart_coral_machinetest/controller/cartscreen_controller.dart';
import 'package:cart_coral_machinetest/model/cart_api_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartWidget extends StatefulWidget {
  const CartWidget({
    super.key,
    this.cartmodel,
    required this.index,
    required this.totalprice,
  });

  final CartApiModel? cartmodel;
  final int index;
  final double totalprice;

  @override
  State<CartWidget> createState() => _CartWidgetState();
}

class _CartWidgetState extends State<CartWidget> {
  @override
  Widget build(BuildContext context) {
    final cartScreenController = Get.find<CartScreenController>();

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Material(
            elevation: 5,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: ListTile(
                leading: CachedNetworkImage(
                  imageUrl: widget.cartmodel?.product.image ?? "",
                  width: 100,
                  fit: BoxFit.contain,
                ),
                title: Text(widget.cartmodel?.product.title ?? ""),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Obx(() => Text(
                        "\$ ${cartScreenController.productAmountCalcu(widget.cartmodel!).toStringAsFixed(2)}")),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          padding: const EdgeInsets.symmetric(horizontal: 0),
                          decoration: BoxDecoration(
                            border: Border.all(width: 2, color: Colors.red),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: IconButton(
                            onPressed: () {
                              cartScreenController
                                  .removeItems(widget.cartmodel!);
                            },
                            icon: const Icon(Icons.remove, size: 15),
                          ),
                        ),
                        const SizedBox(width: 15),
                        Obx(() => Text(
                            widget.cartmodel?.quantity.value.toString() ?? "")),
                        const SizedBox(width: 15),
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            border: Border.all(width: 2, color: Colors.green),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: IconButton(
                            onPressed: () {
                              cartScreenController.addItems(widget.cartmodel!);
                            },
                            icon: const Icon(Icons.add, size: 15),
                          ),
                        ),
                        const Spacer(),
                        IconButton(
                          onPressed: () {
                            cartScreenController.deleteData(widget.index);
                          },
                          icon: const Icon(Icons.delete),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
