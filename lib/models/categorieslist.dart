// To parse this JSON data, do
//
//     final categories = categoriesFromJson(jsonString);

import 'dart:convert';

Categories categoriesFromJson(String str) => Categories.fromJson(json.decode(str));

String categoriesToJson(Categories data) => json.encode(data.toJson());

class Categories {
  List<Drink> drinks;

  Categories({
    required this.drinks,
  });

  factory Categories.fromJson(Map<String, dynamic> json) => Categories(
    drinks: List<Drink>.from(json["drinks"].map((x) => Drink.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "drinks": List<dynamic>.from(drinks.map((x) => x.toJson())),
  };
}

class Drink {
  String strCategory;

  Drink({
    required this.strCategory,
  });

  factory Drink.fromJson(Map<String, dynamic> json) => Drink(
    strCategory: json["strCategory"],
  );

  Map<String, dynamic> toJson() => {
    "strCategory": strCategory,
  };
}
