import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sanaa_os/features/cards/data/pdf_service.dart';
import 'package:sanaa_os/features/clients/controller/clientsController.dart';
import 'package:sanaa_os/features/clients/data/client_model.dart'; // Import your client model

class ClientListScreen extends StatelessWidget {
  final ClientController controller = Get.put(ClientController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sanaa Client Cards', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Container(
        color: Colors.grey[100],
        padding: EdgeInsets.all(16.0),
        child: Obx(() {
          if (controller.isLoading.value) {
            return Center(child: CircularProgressIndicator());
          } else {
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 250, 
                crossAxisSpacing: 16.0,
                mainAxisSpacing: 16.0,
                childAspectRatio: 1.0, 
              ),
              itemCount: controller.clients.length,
              itemBuilder: (context, index) {
                final client = controller.clients[index]; // Now 'client' is of type ClientCards
                return _buildClientCard(client);
              },
            );
          }
        }),
      ),
    );
  }

  Widget _buildClientCard(ClientCards client) { // Updated to use ClientCards
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: InkWell( 
        onTap: () async {
          // Handle card tap (e.g., navigate to details) if needed
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0), 
              child: Text(
                client.clientData.name, // Access name from clientData
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0, 
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              client.clientData.pan, // Access pan from clientData
              style: TextStyle(fontSize: 14.0),
              textAlign: TextAlign.center,
            ),
            Spacer(),
            IconButton(
              icon: Icon(Icons.file_download),
              onPressed: () async {
                final pdfData = await PdfService.generateCertificate(
                  client.clientData.name,
                  client.clientData.pan,
                  client.clientData.cvv,
                  client.clientData.expiryDate.toIso8601String().split('T')[0],
                  client.qrCode, 
                );
                await PdfService.saveAndSharePdf(pdfData, client.clientData.name);
              },
            ),
          ],
        ),
      ),
    );
  }
}