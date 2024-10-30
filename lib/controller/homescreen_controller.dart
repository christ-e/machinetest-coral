import 'dart:convert';
import 'package:cart_coral_machinetest/model/fakestore_api.model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class HomeScreenController extends GetxController {
  var isLoading = false.obs;
  var fakestoreList = <FakeStoreApiModel>[].obs;

  Future<void> getData() async {
    isLoading.value = true;
    Uri url = Uri.parse('https://fakestoreapi.com/products');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      List decodedData = jsonDecode(response.body);
      fakestoreList.value =
          decodedData.map((e) => FakeStoreApiModel.fromJson(e)).toList();
    } else {
      print("Failed");
    }
    isLoading.value = false;
  }
}
