// To parse this JSON data, do
//
//     final productModel = productModelFromJson(jsonString);

import 'dart:convert';

ProductModel productModelFromJson(String str) => ProductModel.fromJson(json.decode(str));

String productModelToJson(ProductModel data) => json.encode(data.toJson());

class ProductModel {
  ProductModel({
    this.popular,
  });

  List<Popular> ? popular;

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
    popular: json["popular"] == null ? null : List<Popular>.from(json["popular"].map((x) => Popular.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "popular": popular == null ? null : List<dynamic>.from(popular!.map((x) => x.toJson())),
  };
}

class Popular {
  Popular({
    this.id,
    this.name,
    this.slug,
    this.description,
    this.typeId,
    this.price,
    this.shopId,
    this.salePrice,
    this.sku,
    this.quantity,
    this.inStock,
    this.isTaxable,
    this.shippingClassId,
    this.status,
    this.productType,
    this.purchasePrice,
    this.unit,
    this.height,
    this.width,
    this.length,
    this.image,
    this.gallery,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.maxPrice,
    this.minPrice,
    this.deadline,
    this.targetSale,
    this.delivryDate,
    this.ordersCount,
    this.type,
    this.categories,
  });

  int ? id;
  String? name;
  String ? slug;
  String ? description;
  int ?typeId;
  int ?price;
  int ?shopId;
  int ?salePrice;
  String? sku;
  int ?quantity;
  int? inStock;
  int ?isTaxable;
  dynamic shippingClassId;
  Status ?status;
  ProductType? productType;
  String? purchasePrice;
  String ? unit;
  dynamic height;
  dynamic width;
  dynamic length;
  ImageElement ? image;
  List<ImageElement> ? gallery;
  dynamic ? deletedAt;
  DateTime ? createdAt;
  DateTime ? updatedAt;
  dynamic  ?maxPrice;
  dynamic ? minPrice;
  DateTime ? deadline;
  int ? targetSale;
  DateTime? delivryDate;
  int ?ordersCount;
  Type ?type;
  List<Category>? categories;

  factory Popular.fromJson(Map<String, dynamic> json) => Popular(
    id: json["id"] == null ? null : json["id"],
    name: json["name"] == null ? null : json["name"],
    slug: json["slug"] == null ? null : json["slug"],
    description: json["description"] == null ? null : json["description"],
    typeId: json["type_id"] == null ? null : json["type_id"],
    price: json["price"] == null ? null : json["price"],
    shopId: json["shop_id"] == null ? null : json["shop_id"],
    salePrice: json["sale_price"] == null ? null : json["sale_price"],
    sku: json["sku"] == null ? null : json["sku"],
    quantity: json["quantity"] == null ? null : json["quantity"],
    inStock: json["in_stock"] == null ? null : json["in_stock"],
    isTaxable: json["is_taxable"] == null ? null : json["is_taxable"],
    shippingClassId: json["shipping_class_id"],
    status: json["status"] == null ? null : statusValues.map![json["status"]],
    productType: json["product_type"] == null ? null : productTypeValues.map![json["product_type"]],
    purchasePrice: json["purchase_price"] == null ? null : json["purchase_price"],
    unit: json["unit"] == null ? null : json["unit"],
    height: json["height"],
    width: json["width"],
    length: json["length"],
    image: json["image"] == null ? null : ImageElement.fromJson(json["image"]),
    gallery: json["gallery"] == null ? null : List<ImageElement>.from(json["gallery"].map((x) => ImageElement.fromJson(x))),
    deletedAt: json["deleted_at"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    maxPrice: json["max_price"],
    minPrice: json["min_price"],
    deadline: json["deadline"] == null ? null : DateTime.parse(json["deadline"]),
    targetSale: json["target_sale"] == null ? null : json["target_sale"],
    delivryDate: json["delivry_date"] == null ? null : DateTime.parse(json["delivry_date"]),
    ordersCount: json["orders_count"] == null ? null : json["orders_count"],
    type: json["type"] == null ? null : Type.fromJson(json["type"]),
    categories: json["categories"] == null ? null : List<Category>.from(json["categories"].map((x) => Category.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "name": name == null ? null : name,
    "slug": slug == null ? null : slug,
    "description": description == null ? null : description,
    "type_id": typeId == null ? null : typeId,
    "price": price == null ? null : price,
    "shop_id": shopId == null ? null : shopId,
    "sale_price": salePrice == null ? null : salePrice,
    "sku": sku == null ? null : sku,
    "quantity": quantity == null ? null : quantity,
    "in_stock": inStock == null ? null : inStock,
    "is_taxable": isTaxable == null ? null : isTaxable,
    "shipping_class_id": shippingClassId,
    "status": status == null ? null : statusValues.reverse[status],
    "product_type": productType == null ? null : productTypeValues.reverse[productType],
    "purchase_price": purchasePrice == null ? null : purchasePrice,
    "unit": unit == null ? null : unit,
    "height": height,
    "width": width,
    "length": length,
    "image": image == null ? null : image!.toJson(),
    "gallery": gallery == null ? null : List<dynamic>.from(gallery!.map((x) => x.toJson())),
    "deleted_at": deletedAt,
    "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
    "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
    "max_price": maxPrice,
    "min_price": minPrice,
    "deadline": deadline == null ? null : deadline!.toIso8601String(),
    "target_sale": targetSale == null ? null : targetSale,
    "delivry_date": delivryDate == null ? null : delivryDate!.toIso8601String(),
    "orders_count": ordersCount == null ? null : ordersCount,
    "type": type == null ? null : type!.toJson(),
    "categories": categories == null ? null : List<dynamic>.from(categories!.map((x) => x.toJson())),
  };
}

class Category {
  Category({
    this.id,
    this.menuId,
    this.name,
    this.slug,
    this.icon,
    this.image,
    this.imageIcon,
    this.details,
    this.parent,
    this.typeId,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.pivot,
  });

  int ? id;
  int ? menuId;
  String ?name;
  String  ?slug;
  Icon ? icon;
  dynamic  ?image;
  String  ?imageIcon;
  String ? details;
  int  ?parent;
  int ? typeId;
  DateTime ? createdAt;
  DateTime ? updatedAt;
  dynamic  ?deletedAt;
  Pivot  ?pivot;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json["id"] == null ? null : json["id"],
    menuId: json["menu_id"] == null ? null : json["menu_id"],
    name: json["name"] == null ? null : json["name"],
    slug: json["slug"] == null ? null : json["slug"],
    icon: json["icon"] == null ? null : iconValues.map![json["icon"]],
    image: json["image"],
    imageIcon: json["image_icon"] == null ? null : json["image_icon"],
    details: json["details"] == null ? null : json["details"],
    parent: json["parent"] == null ? null : json["parent"],
    typeId: json["type_id"] == null ? null : json["type_id"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"],
    pivot: json["pivot"] == null ? null : Pivot.fromJson(json["pivot"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "menu_id": menuId == null ? null : menuId,
    "name": name == null ? null : name,
    "slug": slug == null ? null : slug,
    "icon": icon == null ? null : iconValues.reverse[icon],
    "image": image,
    "image_icon": imageIcon == null ? null : imageIcon,
    "details": details == null ? null : details,
    "parent": parent == null ? null : parent,
    "type_id": typeId == null ? null : typeId,
    "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
    "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
    "deleted_at": deletedAt,
    "pivot": pivot == null ? null : pivot!.toJson(),
  };
}

enum Icon { FRUITS_VEGETABLE, MEAT_FISH }

final iconValues = EnumValues({
  "FruitsVegetable": Icon.FRUITS_VEGETABLE,
  "MeatFish": Icon.MEAT_FISH
});

class ImageElement {
  ImageElement({
    this.thumbnail,
    this.original,
    this.id,
  });

  String ? thumbnail;
  String  ?original;
  int  ?id;

  factory ImageElement.fromJson(Map<String, dynamic> json) => ImageElement(
    thumbnail: json["thumbnail"] == null ? null : json["thumbnail"],
    original: json["original"] == null ? null : json["original"],
    id: json["id"] == null ? null : json["id"],
  );

  Map<String, dynamic> toJson() => {
    "thumbnail": thumbnail == null ? null : thumbnail,
    "original": original == null ? null : original,
    "id": id == null ? null : id,
  };
}

class Pivot {
  Pivot({
    this.productId,
    this.categoryId,
  });

  int ? productId;
  int  ?categoryId;

  factory Pivot.fromJson(Map<String, dynamic> json) => Pivot(
    productId: json["product_id"] == null ? null : json["product_id"],
    categoryId: json["category_id"] == null ? null : json["category_id"],
  );

  Map<String, dynamic> toJson() => {
    "product_id": productId == null ? null : productId,
    "category_id": categoryId == null ? null : categoryId,
  };
}

enum ProductType { SIMPLE }

final productTypeValues = EnumValues({
  "simple": ProductType.SIMPLE
});

enum Status { PUBLISH, DRAFT }

final statusValues = EnumValues({
  "draft": Status.DRAFT,
  "publish": Status.PUBLISH
});

class Type {
  Type({
    this.id,
    this.name,
    this.slug,
    this.icon,
    this.gallery,
    this.createdAt,
    this.updatedAt,
  });

  int ? id;
  Name ? name;
  Slug ? slug;
  Icon  ?icon;
  dynamic gallery;
  DateTime ? createdAt;
  DateTime ? updatedAt;

  factory Type.fromJson(Map<String, dynamic> json) => Type(
    id: json["id"] == null ? null : json["id"],
    name: json["name"] == null ? null : nameValues.map![json["name"]],
    slug: json["slug"] == null ? null : slugValues.map![json["slug"]],
    icon: json["icon"] == null ? null : iconValues.map![json["icon"]],
    gallery: json["gallery"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "name": name == null ? null : nameValues.reverse[name],
    "slug": slug == null ? null : slugValues.reverse[slug],
    "icon": icon == null ? null : iconValues.reverse[icon],
    "gallery": gallery,
    "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
    "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
  };
}

enum Name { GROCERY }

final nameValues = EnumValues({
  "Grocery": Name.GROCERY
});

enum Slug { GROCERY }

final slugValues = EnumValues({
  "grocery": Slug.GROCERY
});

class EnumValues<T> {
  Map<String, T> ? map;
  Map<T, String> ? reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map!.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap!;
  }
}
