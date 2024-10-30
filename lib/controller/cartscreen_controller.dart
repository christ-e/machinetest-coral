import 'package:cart_coral_machinetest/model/cart_api_model.dart';
import 'package:cart_coral_machinetest/model/fakestore_api.model.dart';
import 'package:cart_coral_machinetest/view/screens/screen_home/homescreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class CartScreenController extends GetxController {
  RxList<CartApiModel> cartModelList = <CartApiModel>[].obs;
  RxDouble totalPrice = 0.0.obs;
  // final int shipping = 20;

  void addProduct(FakeStoreApiModel product, BuildContext context) {
    final isCarted =
        cartModelList.any((element) => element.product.id == product.id);

    if (isCarted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Item is already in the cart"),
          duration: Duration(seconds: 2),
        ),
      );
    } else {
      cartModelList.add(CartApiModel(product: product));
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Product Added"),
            content: const Text("The product has been added to your cart!"),
            actions: [
              TextButton(
                child: const Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
    calculation();
  }

  void deleteData(int index) {
    cartModelList.removeAt(index);
    calculation();
  }

  void addItems(CartApiModel model) {
    model.quantity.value++;
    calculation();
  }

  void removeItems(CartApiModel model) {
    if (model.quantity.value <= 1) {
      print("Minimum Quantity required");
    } else {
      model.quantity.value--;
      calculation();
    }
  }

  double productAmountCalcu(CartApiModel model) {
    return model.product.price! * model.quantity.value;
  }

  void calculation() {
    totalPrice.value = cartModelList.fold(0, (sum, item) {
      return sum + item.quantity.value * (item.product.price ?? 0);
    });
  }

  double grandTotal() {
    calculation();
    return totalPrice.value;
  }

  void alertbox(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      useRootNavigator: false,
      context: context,
      builder: (BuildContext context) {
        Future.delayed(const Duration(seconds: 3), () {
          Navigator.pushAndRemoveUntil(
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
              (route) => false);
        });

        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 200,
                width: 400,
                child:
                    Lottie.asset("assets/images/Animation-1728884739155.json"),
              ),
              const Text(
                'Order Placed Successfully',
                style: TextStyle(fontSize: 20),
              ),
            ],
          ),
          actions: [
            Center(
              child: TextButton(
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
                child: Container(),
              ),
            ),
          ],
        );
      },
    );
  }
}
