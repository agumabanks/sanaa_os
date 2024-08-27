// client_controller.dart
import 'package:get/get.dart';
import 'package:sanaa_os/features/clients/data/client_model.dart';
// import 'client_model.dart';
import 'package:http/http.dart' as http;

class ClientController extends GetxController {
  var clients = <ClientCards>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    fetchClients();
    super.onInit();
  }

  void fetchClients() async {
    try {
      isLoading(true);
      final response = await http.get(Uri.parse('https://lendsup.sanaa.co/api/v1/client-cards'));
      if (response.statusCode == 200) {
        clients(clientCardsFromJson(response.body));
      } else {
        Get.snackbar('Error', 'Failed to fetch client data');
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading(false);
    }
  }

  Future<void> downloadClientCard(ClientCards client) async {
    // Add your PDF generation and download logic here.
  }
}
