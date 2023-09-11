// To parse this JSON data, do
//
//     final foodMenuModel = foodMenuModelFromJson(jsonString);

import 'dart:convert';

FoodMenuModel foodMenuModelFromJson(String str) => FoodMenuModel.fromJson(json.decode(str));

String foodMenuModelToJson(FoodMenuModel data) => json.encode(data.toJson());

class FoodMenuModel {
  List<FoodMenuModelDatum>? data;
  Links? links;
  Meta? meta;

  FoodMenuModel({
     this.data,
     this.links,
     this.meta,
  });

  factory FoodMenuModel.fromJson(Map<String, dynamic> json) => FoodMenuModel(
    data: List<FoodMenuModelDatum>.from(json["data"].map((x) => FoodMenuModelDatum.fromJson(x))),
    links: Links.fromJson(json["links"]),
    meta: Meta.fromJson(json["meta"]),
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
    "links": links!.toJson(),
    "meta": meta!.toJson(),
  };
}

class FoodMenuModelDatum {
  String? name;
  String? slug;
  String? image;
  Foods? foods;

  FoodMenuModelDatum({
     this.name,
     this.slug,
     this.image,
     this.foods,
  });

  factory FoodMenuModelDatum.fromJson(Map<String, dynamic> json) => FoodMenuModelDatum(
    name: json["name"],
    slug: json["slug"],
    image: json["image"],
    foods: Foods.fromJson(json["foods"]),
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "slug": slug,
    "image": image,
    "foods": foods?.toJson(),
  };
}

class FoodsDatum {
  String? name;
  String? slug;
  String? image;
  String? price;
  String? taxVat;
  String? calorie;
  String? description;
  Allergies? allergies;
  Addons? addons;
  Variants? variants;

  FoodsDatum({
     this.name,
     this.slug,
     this.image,
     this.price,
     this.taxVat,
     this.calorie,
     this.description,
     this.allergies,
     this.addons,
     this.variants,
  });

  factory FoodsDatum.fromJson(Map<String, dynamic> json) => FoodsDatum(
    name: json["name"],
    slug: json["slug"],
    image: json["image"],
    price: json["price"],
    taxVat: json["tax_vat"],
    calorie: json["calorie"],
    description: json["description"],
    allergies:json["allergies"]==null?null: Allergies.fromJson(json["allergies"]),
    addons:json["addons"]==null?null: Addons.fromJson(json["addons"]),
    variants:json["variants"]==null?null: Variants.fromJson(json["variants"]),
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "slug": slug,
    "image": image,
    "price": price,
    "tax_vat": taxVat,
    "calorie": calorie,
    "description": description,
    "allergies": allergies?.toJson(),
    "addons": addons?.toJson(),
    "variants": variants?.toJson(),
  };


  FoodsDatum.copy(FoodsDatum value) {
    name= value.name;
    slug=  value.slug;
    image=  value.image;
    price=  value.price;
    taxVat=  value.taxVat;
    calorie=  value.calorie;
    description=  value.description;
    allergies=  value.allergies;
    addons= value.addons;
    variants=  value.variants;
  }

  FoodsDatum clone() {
    return FoodsDatum.copy(this);
  }
}

class Foods {
  List<FoodsDatum>? data;

  Foods({
     this.data,
  });

  factory Foods.fromJson(Map<String, dynamic> json) => Foods(
    data: List<FoodsDatum>.from(json["data"].map((x) => FoodsDatum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Allergies {
  List<AllergiesDatum>? data;

  Allergies({
     this.data,
  });

  factory Allergies.fromJson(Map<String, dynamic> json) => Allergies(
    data: List<AllergiesDatum>.from(json["data"].map((x) => AllergiesDatum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class AllergiesDatum {
  int id;
  String name;
  String image;

  AllergiesDatum({
    required this.id,
    required this.name,
    required this.image,
  });

  factory AllergiesDatum.fromJson(Map<String, dynamic> json) => AllergiesDatum(
    id: json["id"],
    name: json["name"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "image": image,
  };
}

class AddonsDatum {
  int? id;
  String? name;
  String? price;
  SubAddons? subAddons;

  AddonsDatum({
     this.id,
     this.name,
     this.price,
    this.subAddons,
  });

  factory AddonsDatum.fromJson(Map<String, dynamic>? json) => AddonsDatum(
    id: json?["id"],
    name: json?["name"],
    price: json?["price"],
    subAddons: json?["subAddons"] == null ? null : SubAddons.fromJson(json?["subAddons"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "price": price,
    "subAddons": subAddons?.toJson(),
  };
}
class SubAddons {
  List<SubAddonsDatum>? data;

  SubAddons({
    this.data,
  });

  factory SubAddons.fromJson(Map<String, dynamic>? json) => SubAddons(
    data: List<SubAddonsDatum>.from(json?["data"].map((x) => SubAddonsDatum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}
class SubAddonsDatum {
  int? id;
  String? name;
  String? price;
  bool isSelected= false;

  SubAddonsDatum({
    this.id,
    this.name,
    this.price,
  });

  factory SubAddonsDatum.fromJson(Map<String, dynamic>? json) => SubAddonsDatum(
    id: json?["id"],
    name: json?["name"],
    price: json?["price"],);

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "price": price,
  };
}

class Addons {
  List<AddonsDatum>? data;

  Addons({
     this.data,
  });

  factory Addons.fromJson(Map<String, dynamic>? json) => Addons(
    data: List<AddonsDatum>.from(json?["data"].map((x) => AddonsDatum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Variants {
  List<VariantsDatum>? data;

  Variants({
     this.data,
  });

  factory Variants.fromJson(Map<String, dynamic> json) => Variants(
    data: List<VariantsDatum>.from(json["data"].map((x) => VariantsDatum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class VariantsDatum {
  int id;
  Name name;
  String price;

  VariantsDatum({
    required this.id,
    required this.name,
    required this.price,
  });

  factory VariantsDatum.fromJson(Map<String, dynamic> json) => VariantsDatum(
    id: json["id"],
    name: nameValues.map[json["name"]]!,
    price: json["price"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": nameValues.reverse[name],
    "price": price,
  };
}

enum Name {
  BLACK,
  DOUBLE,
  HAM_CHEESE,
  REGULAR,
  SINGLE,
  WHITE
}

final nameValues = EnumValues({
  "Black": Name.BLACK,
  "Double": Name.DOUBLE,
  "Ham & Cheese": Name.HAM_CHEESE,
  "Regular": Name.REGULAR,
  "Single": Name.SINGLE,
  "White": Name.WHITE
});

class Links {
  String? first;
  String?last;
  dynamic? prev;
  String? next;

  Links({
     this.first,
     this.last,
     this.prev,
     this.next,
  });

  factory Links.fromJson(Map<String, dynamic> json) => Links(
    first: json["first"],
    last: json["last"],
    prev: json["prev"],
    next: json["next"],
  );

  Map<String, dynamic> toJson() => {
    "first": first,
    "last": last,
    "prev": prev,
    "next": next,
  };
}

class Meta {
  int? currentPage;
  int? from;
  int? lastPage;
  List<Link>? links;
  String? path;
  int? perPage;
  int? to;
  int? total;

  Meta({
     this.currentPage,
     this.from,
     this.lastPage,
     this.links,
     this.path,
     this.perPage,
     this.to,
     this.total,
  });

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
    currentPage: json["current_page"],
    from: json["from"],
    lastPage: json["last_page"],
    links: List<Link>.from(json["links"].map((x) => Link.fromJson(x))),
    path: json["path"],
    perPage: json["per_page"],
    to: json["to"],
    total: json["total"],
  );

  Map<String, dynamic> toJson() => {
    "current_page": currentPage,
    "from": from,
    "last_page": lastPage,
    "links": List<dynamic>.from(links!.map((x) => x.toJson())),
    "path": path,
    "per_page": perPage,
    "to": to,
    "total": total,
  };
}

class Link {
  String? url;
  String label;
  bool active;

  Link({
    required this.url,
    required this.label,
    required this.active,
  });

  factory Link.fromJson(Map<String, dynamic> json) => Link(
    url: json["url"],
    label: json["label"],
    active: json["active"],
  );

  Map<String, dynamic> toJson() => {
    "url": url,
    "label": label,
    "active": active,
  };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
