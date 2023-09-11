// To parse this JSON data, do
//
//     final cartItemModel = cartItemModelFromJson(jsonString);

import 'dart:convert';

CartItemModel cartItemModelFromJson(String str) =>
    CartItemModel.fromJson(json.decode(str));

String cartItemModelToJson(CartItemModel data) => json.encode(data.toJson());

class CartItemModel {
  String? slug;
  int? quantity;
  Addons? addons;
  Variants? variants;
  String? price;
  String? note;

  CartItemModel({
    this.slug,
    this.quantity,
    this.addons,
    this.variants,
    this.price,
    this.note
  });

  factory CartItemModel.fromJson(Map<String, dynamic> json) => CartItemModel(
        slug: json["slug"],
        quantity: json["quantity"],
        addons:json["addons"] != null? Addons.fromJson(json["addons"]):null,
        variants: json["variants"] != null?Variants.fromJson(json["variants"]):null,
        price: json["price"],
        note: json["note"],
      );

  Map<String, dynamic> toJson() => {
        "slug": slug,
        "quantity": quantity,
        "addons": addons?.toJson(),
        "variants": variants?.toJson(),
        "price": price,
        "note": note
      };
}

class Addons {
  List<AddonsDatum>? data;

  Addons({
    this.data,
  });

  factory Addons.fromJson(Map<String, dynamic> json) => Addons(
        data: List<AddonsDatum>.from(
            json["data"].map((x) => AddonsDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? null
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class AddonsDatum {
  int? id;
  int? quantity;
  SubAddons? subAddons;

  AddonsDatum({
    this.id,
    this.quantity,
    this.subAddons,
  });

  factory AddonsDatum.fromJson(Map<String, dynamic> json) => AddonsDatum(
        id: json["id"],
        quantity: json["quantity"],
        subAddons: SubAddons.fromJson(json["subAddons"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "quantity": quantity,
        "subAddons": subAddons?.toJson(),
      };
}

class SubAddons {
  List<SubAddonsDatum>? data;

  SubAddons({
    this.data,
  });

  factory SubAddons.fromJson(Map<String, dynamic> json) => SubAddons(
        data: List<SubAddonsDatum>.from(
            json["data"].map((x) => SubAddonsDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? null
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class SubAddonsDatum {
  int? id;
  int? quantity;

  SubAddonsDatum({
    this.id,
    this.quantity,
  });

  factory SubAddonsDatum.fromJson(Map<String, dynamic> json) => SubAddonsDatum(
        id: json["id"],
        quantity: json["quantity"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "quantity": quantity,
      };
}

class Variants {
  List<VariantsDatum>? data;

  Variants({
    this.data,
  });

  factory Variants.fromJson(Map<String, dynamic> json) => Variants(
        data: List<VariantsDatum>.from(
            json["data"].map((x) => VariantsDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? null
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class VariantsDatum {
  int? id;
  String? name;

  VariantsDatum({
    this.id,
    this.name,
  });

  factory VariantsDatum.fromJson(Map<String, dynamic> json) => VariantsDatum(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
