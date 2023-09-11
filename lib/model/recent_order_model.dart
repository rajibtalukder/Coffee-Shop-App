// To parse this JSON data, do
//
//     final recentOrderModel = recentOrderModelFromJson(jsonString);

import 'dart:convert';

RecentOrderModel recentOrderModelFromJson(String str) => RecentOrderModel.fromJson(json.decode(str));

String recentOrderModelToJson(RecentOrderModel data) => json.encode(data.toJson());

class RecentOrderModel {
  Data? data;

  RecentOrderModel({
    this.data,
  });

  factory RecentOrderModel.fromJson(Map<String, dynamic> json) => RecentOrderModel(
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "data": data?.toJson(),
  };
}

class Data {
  String? invoice;
  String? status;
  String? type;
  String? deliveryType;
  Address? address;
  String? grandTotal;
  String? dateTime;
  dynamic runningTime;
  List<Item>? items;

  Data({
    this.invoice,
    this.status,
    this.type,
    this.deliveryType,
    this.address,
    this.grandTotal,
    this.dateTime,
    this.runningTime,
    this.items,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    invoice: json["invoice"],
    status: json["status"],
    type: json["type"],
    deliveryType: json["delivery_type"],
    address: Address.fromJson(json["address"]),
    grandTotal: json["grand_total"],
    dateTime: json["date_time"],
    runningTime: json["running_time"],
    items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "invoice": invoice,
    "status": status,
    "type": type,
    "delivery_type": deliveryType,
    "address": address?.toJson(),
    "grand_total": grandTotal,
    "date_time": dateTime,
    "running_time": runningTime,
    "items": List<dynamic>.from(items!.map((x) => x.toJson())),
  };
}

class Address {
  String? type;
  String? location;

  Address({
    this.type,
    this.location,
  });

  factory Address.fromJson(Map<String, dynamic> json) => Address(
    type: json["type"],
    location: json["location"],
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "location": location,
  };
}

class Item {
  String? name;
  int? quantity;
  String? image;
  String? variant;
  List<Addon>? addons;

  Item({
    this.name,
    this.quantity,
    this.image,
    this.variant,
    this.addons,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    name: json["name"],
    quantity: json["quantity"],
    image: json["image"],
    variant: json["variant"],
    addons: List<Addon>.from(json["addons"].map((x) => Addon.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "quantity": quantity,
    "image": image,
    "variant": variant,
    "addons": List<dynamic>.from(addons!.map((x) => x.toJson())),
  };
}

class Addon {
  String? name;
  int? quantity;

  Addon({
    this.name,
    this.quantity,
  });

  factory Addon.fromJson(Map<String, dynamic> json) => Addon(
    name: json["name"],
    quantity: json["quantity"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "quantity": quantity,
  };
}
