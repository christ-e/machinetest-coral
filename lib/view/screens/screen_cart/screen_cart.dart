import 'package:cart_coral_machinetest/controller/cartscreen_controller.dart';
import 'package:cart_coral_machinetest/view/screens/screen_cart/widget/cart_widget.dart';
import 'package:cart_coral_machinetest/view/screens/screen_home/homescreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cartController = Get.put(CartScreenController());

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      HomeScreen(),
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) {
                    return SlideTransition(
                      position: Tween<Offset>(
                        begin: const Offset(0.0, 1.0),
                        end: Offset.zero,
                      ).animate(animation),
                      child: FadeTransition(
                        opacity: animation,
                        child: child,
                      ),
                    );
                  },
                ),
              );
            },
            icon: const Icon(Icons.arrow_back)),
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.shopping_cart_rounded),
            SizedBox(width: 5),
            Text("CART",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
          ],
        ),
      ),
      body: cartController.cartModelList.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(),
                  SizedBox(
                    width: 150,
                    height: 150,
                    child: Image.asset(
                      "assets/images/image-removebg-preview (13).png",
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text('No orders available.',
                      style: TextStyle(fontSize: 23)),
                  const Spacer(),
                  Material(
                    elevation: 5,
                    child: Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                      ),
                      padding: const EdgeInsets.only(top: 10),
                      child: Column(
                        children: [
                          _buildRow(
                            title: "Total items in list",
                            value: "\$ 0",
                          ),
                          const SizedBox(height: 20),
                          _buildRow(
                            title: "Total Amount",
                            value: "\$ 0",
                          ),
                          const SizedBox(height: 20),
                          _buildRow(
                            title: "Grand Total",
                            value: "\$ 0",
                            isBold: true,
                            fontSize: 30,
                          ),
                          GestureDetector(
                            onTap: () {
                              cartController.alertbox(context);
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              decoration:
                                  const BoxDecoration(color: Colors.green),
                              width: double.infinity,
                              child: const Center(
                                child: Text(
                                  "Proceed",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: Obx(() => ListView.separated(
                        itemBuilder: (context, index) => CartWidget(
                          cartmodel: cartController.cartModelList[index],
                          index: index,
                          totalprice: cartController.totalPrice.value,
                        ),
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 10),
                        itemCount: cartController.cartModelList.length,
                      )),
                ),
                Material(
                  elevation: 5,
                  child: Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    padding: const EdgeInsets.only(top: 10),
                    child: Column(
                      children: [
                        Obx(() => _buildRow(
                              title: "Total items in list",
                              value: cartController.cartModelList.length
                                  .toString(),
                            )),
                        const SizedBox(height: 20),
                        Obx(() => _buildRow(
                              title: "Total Amount",
                              value:
                                  "\$${cartController.totalPrice.value.toStringAsFixed(2)}",
                            )),
                        const SizedBox(height: 20),
                        Obx(() => _buildRow(
                              title: "Grand Total",
                              value:
                                  "\$${(cartController.grandTotal()).toStringAsFixed(2)}",
                              isBold: true,
                              fontSize: 30,
                            )),
                        GestureDetector(
                          onTap: () {
                            cartController.alertbox(context);
                            // ScaffoldMessenger.of(context).showSnackBar(
                            //   const SnackBar(content: Text("Proceeding to checkout")),
                            // );
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            decoration:
                                const BoxDecoration(color: Colors.green),
                            width: double.infinity,
                            child: const Center(
                              child: Text(
                                "Proceed",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  Widget _buildRow({
    required String title,
    required String value,
    bool isBold = false,
    double fontSize = 18,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text(
          title,
          style: TextStyle(
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            fontSize: fontSize,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            fontSize: fontSize,
          ),
        ),
      ],
    );
  }
}
