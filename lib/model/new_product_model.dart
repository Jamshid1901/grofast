

import 'dart:convert';

NewProductModel? newProductModelFromJson(String str) => NewProductModel.fromJson(json.decode(str));

String newProductModelToJson(NewProductModel? data) => json.encode(data!.toJson());

class NewProductModel {
  NewProductModel({
    this.data,
    this.links,
    this.meta,
  });

  List<Datum?>? data;
  Links? links;
  Meta? meta;

  factory NewProductModel.fromJson(Map<String, dynamic> json) => NewProductModel(
    data: json["data"] == null ? [] : List<Datum?>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    links: Links.fromJson(json["links"]),
    meta: Meta.fromJson(json["meta"]),
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x!.toJson())),
    "links": links!.toJson(),
    "meta": meta!.toJson(),
  };
}

class Datum {
  Datum({
    this.id,
    this.uuid,
    this.shopId,
    this.categoryId,
    this.tax,
    this.barCode,
    this.status,
    this.active,
    this.img,
    this.minQty,
    this.maxQty,
    this.translation,
  });

  int? id;
  String? uuid;
  int? shopId;
  int? categoryId;
  int? tax;
  String? barCode;
  String? status;
  bool? active;
  String? img;
  int? minQty;
  int? maxQty;

  Translation? translation;


  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    uuid: json["uuid"],
    shopId: json["shop_id"],
    categoryId: json["category_id"],
    tax: json["tax"],
    barCode: json["bar_code"],
    status: json["status"],
    active: json["active"],
    img: json["img"],
    minQty: json["min_qty"],
    maxQty: json["max_qty"],

    translation: Translation.fromJson(json["translation"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "uuid": uuid,
    "shop_id": shopId,
    "category_id": categoryId,
    "tax": tax,
    "bar_code": barCode,
    "status": status,
    "active": active,
    "img": img,
    "min_qty": minQty,
    "max_qty": maxQty,
  };
}

class Category {
  Category({
    this.id,
    this.uuid,
    this.active,
    this.translation,
    this.locales,
    this.translations,
  });

  int? id;
  String? uuid;
  bool? active;
  Translation? translation;
  List<Locale?>? locales;
  List<Translation?>? translations;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json["id"],
    uuid: json["uuid"],
    active: json["active"],
    translation: Translation.fromJson(json["translation"]),
    locales: json["locales"] == null ? [] : List<Locale?>.from(json["locales"]!.map((x) => localeValues!.map[x])),
    translations: json["translations"] == null ? [] : json["translations"] == null ? [] : List<Translation?>.from(json["translations"]!.map((x) => Translation.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "uuid": uuid,
    "active": active,
    "translation": translation!.toJson(),
    "locales": locales == null ? [] : List<dynamic>.from(locales!.map((x) => localeValues.reverse![x])),
    "translations": translations == null ? [] : translations == null ? [] : List<dynamic>.from(translations!.map((x) => x!.toJson())),
  };
}

enum Locale { EN }

final localeValues = EnumValues({
  "en": Locale.EN
});

class Translation {
  Translation({
    this.id,
    this.locale,
    this.title,
    this.description,
  });

  int? id;
  Locale? locale;
  String? title;
  String? description;

  factory Translation.fromJson(Map<String, dynamic> json) => Translation(
    id: json["id"],
    locale: localeValues!.map[json["locale"]],
    title: json["title"],
    description: json["description"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "locale": localeValues.reverse![locale],
    "title": title,
    "description": description,
  };
}

class Discount {
  Discount({
    this.id,
    this.shopId,
    this.type,
    this.price,
    this.start,
    this.end,
    this.active,
    this.img,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  int? shopId;
  String? type;
  int? price;
  DateTime? start;
  DateTime? end;
  int? active;
  String? img;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Discount.fromJson(Map<String, dynamic> json) => Discount(
    id: json["id"],
    shopId: json["shop_id"],
    type: json["type"],
    price: json["price"],
    start: DateTime.parse(json["start"]),
    end: DateTime.parse(json["end"]),
    active: json["active"],
    img: json["img"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "shop_id": shopId,
    "type": type,
    "price": price,
    "start": "${start!.year.toString().padLeft(4, '0')}-${start!.month.toString().padLeft(2, '0')}-${start!.day.toString().padLeft(2, '0')}",
    "end": "${end!.year.toString().padLeft(4, '0')}-${end!.month.toString().padLeft(2, '0')}-${end!.day.toString().padLeft(2, '0')}",
    "active": active,
    "img": img,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}

class Bonus {
  Bonus({
    this.id,
    this.bonusableType,
    this.bonusableId,
    this.bonusQuantity,
    this.bonusStockId,
    this.value,
    this.type,
    this.status,
    this.expiredAt,
    this.bonusStock,
  });

  int? id;
  String? bonusableType;
  int? bonusableId;
  int? bonusQuantity;
  int? bonusStockId;
  int? value;
  String? type;
  bool? status;
  DateTime? expiredAt;
  Stock? bonusStock;

  factory Bonus.fromJson(Map<String, dynamic> json) => Bonus(
    id: json["id"],
    bonusableType: json["bonusable_type"],
    bonusableId: json["bonusable_id"],
    bonusQuantity: json["bonus_quantity"],
    bonusStockId: json["bonus_stock_id"],
    value: json["value"],
    type: json["type"],
    status: json["status"],
    expiredAt: DateTime.parse(json["expired_at"]),
    bonusStock: Stock.fromJson(json["bonusStock"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "bonusable_type": bonusableType,
    "bonusable_id": bonusableId,
    "bonus_quantity": bonusQuantity,
    "bonus_stock_id": bonusStockId,
    "value": value,
    "type": type,
    "status": status,
    "expired_at": "${expiredAt!.year.toString().padLeft(4, '0')}-${expiredAt!.month.toString().padLeft(2, '0')}-${expiredAt!.day.toString().padLeft(2, '0')}",
    "bonusStock": bonusStock!.toJson(),
  };
}

class Stock {
  Stock({
    this.id,
    this.countableId,
    this.price,
    this.quantity,
    this.tax,
    this.totalPrice,
    this.extras,
    this.bonus,
    this.product,
  });

  int? id;
  int? countableId;
  double? price;
  int? quantity;
  double? tax;
  double? totalPrice;
  List<Extra?>? extras;
  Bonus? bonus;
  Product? product;

  factory Stock.fromJson(Map<String, dynamic> json) => Stock(
    id: json["id"],
    countableId: json["countable_id"],
    price: json["price"].toDouble(),
    quantity: json["quantity"],
    tax: json["tax"].toDouble(),
    totalPrice: json["total_price"].toDouble(),
    extras: json["extras"] == null ? [] : json["extras"] == null ? [] : List<Extra?>.from(json["extras"]!.map((x) => Extra.fromJson(x))),
    bonus: json["bonus"],
    product: json["product"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "countable_id": countableId,
    "price": price,
    "quantity": quantity,
    "tax": tax,
    "total_price": totalPrice,
    "extras": extras == null ? [] : extras == null ? [] : List<dynamic>.from(extras!.map((x) => x!.toJson())),
    "bonus": bonus,
    "product": product,
  };
}

class Extra {
  Extra({
    this.id,
    this.extraGroupId,
    this.value,
    this.active,
    this.group,
  });

  int? id;
  int? extraGroupId;
  String? value;
  bool? active;
  Group? group;

  factory Extra.fromJson(Map<String, dynamic> json) => Extra(
    id: json["id"],
    extraGroupId: json["extra_group_id"],
    value: json["value"],
    active: json["active"],
    group: Group.fromJson(json["group"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "extra_group_id": extraGroupId,
    "value": value,
    "active": active,
    "group": group!.toJson(),
  };
}

class Group {
  Group({
    this.id,
    this.type,
    this.active,
    this.translation,
    this.locales,
  });

  int? id;
  String? type;
  bool? active;
  Translation? translation;
  List<String?>? locales;

  factory Group.fromJson(Map<String, dynamic> json) => Group(
    id: json["id"],
    type: json["type"],
    active: json["active"],
    translation: Translation.fromJson(json["translation"]),
    locales: json["locales"] == null ? [] : List<String?>.from(json["locales"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "type": type,
    "active": active,
    "translation": translation!.toJson(),
    "locales": locales == null ? [] : List<dynamic>.from(locales!.map((x) => x)),
  };
}

class Product {
  Product({
    this.id,
    this.uuid,
    this.tax,
    this.barCode,
    this.status,
    this.active,
    this.img,
    this.minQty,
    this.maxQty,
    this.discounts,
    this.translation,
    this.locales,
  });

  int? id;
  String? uuid;
  int? tax;
  String? barCode;
  String? status;
  bool? active;
  String? img;
  int? minQty;
  int? maxQty;
  List<dynamic>? discounts;
  Translation? translation;
  List<Locale?>? locales;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["id"],
    uuid: json["uuid"],
    tax: json["tax"],
    barCode: json["bar_code"],
    status: json["status"],
    active: json["active"],
    img: json["img"],
    minQty: json["min_qty"],
    maxQty: json["max_qty"],
    discounts: json["discounts"] == null ? [] : List<dynamic>.from(json["discounts"]!.map((x) => x)),
    translation: Translation.fromJson(json["translation"]),
    locales: json["locales"] == null ? [] : List<Locale?>.from(json["locales"]!.map((x) => localeValues!.map[x])),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "uuid": uuid,
    "tax": tax,
    "bar_code": barCode,
    "status": status,
    "active": active,
    "img": img,
    "min_qty": minQty,
    "max_qty": maxQty,
    "discounts": discounts == null ? [] : List<dynamic>.from(discounts!.map((x) => x)),
    "translation": translation!.toJson(),
    "locales": locales == null ? [] : List<dynamic>.from(locales!.map((x) => localeValues.reverse![x])),
  };
}

class Unit {
  Unit({
    this.id,
    this.active,
    this.position,
    this.createdAt,
    this.updatedAt,
    this.translation,
    this.locales,
    this.translations,
  });

  int? id;
  bool? active;
  String? position;
  DateTime? createdAt;
  DateTime? updatedAt;
  Translation? translation;
  List<Locale?>? locales;
  List<Translation?>? translations;

  factory Unit.fromJson(Map<String, dynamic> json) => Unit(
    id: json["id"],
    active: json["active"],
    position: json["position"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    translation: Translation.fromJson(json["translation"]),
    locales: json["locales"] == null ? [] : List<Locale?>.from(json["locales"]!.map((x) => localeValues!.map[x])),
    translations: json["translations"] == null ? [] : json["translations"] == null ? [] : List<Translation?>.from(json["translations"]!.map((x) => Translation.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "active": active,
    "position": position,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "translation": translation!.toJson(),
    "locales": locales == null ? [] : List<dynamic>.from(locales!.map((x) => localeValues.reverse![x])),
    "translations": translations == null ? [] : translations == null ? [] : List<dynamic>.from(translations!.map((x) => x!.toJson())),
  };
}

class Links {
  Links({
    this.first,
    this.last,
    this.prev,
    this.next,
  });

  String? first;
  String? last;
  String? prev;
  String? next;

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

  int? currentPage;
  int? from;
  int? lastPage;
  List<Link?>? links;
  String? path;
  String? perPage;
  int? to;
  int? total;

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
    currentPage: json["current_page"],
    from: json["from"],
    lastPage: json["last_page"],
    links: json["links"] == null ? [] : List<Link?>.from(json["links"]!.map((x) => Link.fromJson(x))),
    path: json["path"],
    perPage: json["per_page"],
    to: json["to"],
    total: json["total"],
  );

  Map<String, dynamic> toJson() => {
    "current_page": currentPage,
    "from": from,
    "last_page": lastPage,
    "links": links == null ? [] : List<dynamic>.from(links!.map((x) => x!.toJson())),
    "path": path,
    "per_page": perPage,
    "to": to,
    "total": total,
  };
}

class Link {
  Link({
    this.url,
    this.label,
    this.active,
  });

  String? url;
  String? label;
  bool? active;

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
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String>? get reverse {
    reverseMap ??= map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
