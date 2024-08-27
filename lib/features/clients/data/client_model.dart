// client_model.dart
import 'dart:convert';

List<ClientCards> clientCardsFromJson(String str) => List<ClientCards>.from(json.decode(str).map((x) => ClientCards.fromJson(x)));

String clientCardsToJson(List<ClientCards> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ClientCards {
  ClientData clientData;
  String qrCode;

  ClientCards({
    required this.clientData,
    required this.qrCode,
  });

  factory ClientCards.fromJson(Map<String, dynamic> json) => ClientCards(
    clientData: ClientData.fromJson(json["client_data"]),
    qrCode: json["qr_code"],
  );

  Map<String, dynamic> toJson() => {
    "client_data": clientData.toJson(),
    "qr_code": qrCode,
  };
}

class ClientData {
  int clientid;
  String phone;
  String cvv;
  DateTime expiryDate;
  String pan;
  CardStatus cardStatus;
  String name;

  ClientData({
    required this.clientid,
    required this.phone,
    required this.cvv,
    required this.expiryDate,
    required this.pan,
    required this.cardStatus,
    required this.name,
  });

  factory ClientData.fromJson(Map<String, dynamic> json) => ClientData(
    clientid: json["clientid"],
    phone: json["phone"],
    cvv: json["cvv"],
    expiryDate: DateTime.parse(json["expiry_date"]),
    pan: json["pan"],
    cardStatus: cardStatusValues.map[json["card_status"]]!,
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "clientid": clientid,
    "phone": phone,
    "cvv": cvv,
    "expiry_date": "${expiryDate.year.toString().padLeft(4, '0')}-${expiryDate.month.toString().padLeft(2, '0')}-${expiryDate.day.toString().padLeft(2, '0')}",
    "pan": pan,
    "card_status": cardStatusValues.reverse[cardStatus],
    "name": name,
  };
}

enum CardStatus {
  ACTIVE
}

final cardStatusValues = EnumValues({
  "active": CardStatus.ACTIVE
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
