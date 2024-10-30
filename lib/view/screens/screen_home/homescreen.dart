import 'package:cached_network_image/cached_network_image.dart';
import 'package:cart_coral_machinetest/controller/cartscreen_controller.dart';
import 'package:cart_coral_machinetest/controller/homescreen_controller.dart';
import 'package:cart_coral_machinetest/database/firebase_db.dart';
import 'package:cart_coral_machinetest/model/fakestore_api.model.dart';
import 'package:cart_coral_machinetest/view/screens/screen_cart/screen_cart.dart';
import 'package:cart_coral_machinetest/view/screens/screen_login/login_fir.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quickalert/quickalert.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeScreenController homeController = Get.put(HomeScreenController());
  final CartScreenController cartController = Get.put(CartScreenController());

  @override
  void initState() {
    super.initState();
    homeController.getData();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "FAKE STORE",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
        ),
        leading: IconButton(
            onPressed: () {
              QuickAlert.show(
                context: context,
                type: QuickAlertType.confirm,
                text: 'Do you want to logout',
                confirmBtnText: 'Yes',
                cancelBtnText: 'No',
                confirmBtnColor: Colors.green,
                onConfirmBtnTap: () {
                  FirebaseHelper().signOut().then((result) => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginScreen())));
                },
              );
            },
            icon: const Icon(Icons.logout)),
        actions: [
          IconButton(
            onPressed: () {
              Get.off(() => const CartScreen());
            },
            icon: const Icon(Icons.shopping_cart_checkout_outlined),
          ),
        ],
      ),
      body: Obx(() {
        if (homeController.isLoading.value) {
          homeController.getData();

          return const Center(child: CircularProgressIndicator());
        } else {
          return Padding(
            padding: const EdgeInsets.all(10),
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.7,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemBuilder: (context, index) {
                FakeStoreApiModel product = homeController.fakestoreList[index];
                return Stack(
                  alignment: Alignment.topRight,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 10),
                      decoration: BoxDecoration(
                        border: Border.all(width: 1),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CachedNetworkImage(
                              imageUrl: product.image ?? "",
                              height: 100,
                              fit: BoxFit.fill),
                          const SizedBox(height: 10),
                          Text(
                            product.title ?? "",
                            maxLines: 4,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 14),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            "\$${product.price}",
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      top: 0,
                      right: 0,
                      child: IconButton(
                        onPressed: () {
                          cartController.addProduct(product, context);
                        },
                        icon: const Icon(
                          Icons.shopping_cart,
                          size: 30,
                        ),
                      ),
                    ),
                  ],
                );
              },
              itemCount: homeController.fakestoreList.length,
            ),
          );
        }
      }),
    );
  }
}
