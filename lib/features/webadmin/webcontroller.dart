import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomeController extends GetxController {
  var isLoading = true.obs;
  var data = [].obs;

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  void fetchData() async {
    try {
      final response = await http.get(Uri.parse('https://lendsup.sanaa.co/api/endpoint'));
      if (response.statusCode == 200) {
        data.value = json.decode(response.body);
      } else {
        // Handle errors
      }
    } catch (e) {
      // Handle exceptions
    } finally {
      isLoading.value = false;
    }
  }
}
