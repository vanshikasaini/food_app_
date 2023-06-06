// To parse this JSON data, do
//
//     final specificCateList = specificCateListFromJson(jsonString);

import 'dart:convert';

SpecificCateList specificCateListFromJson(String str) => SpecificCateList.fromJson(json.decode(str));

String specificCateListToJson(SpecificCateList data) => json.encode(data.toJson());

class SpecificCateList {
  List<Drink> drinks;

  SpecificCateList({
    required this.drinks,
  });

  factory SpecificCateList.fromJson(Map<String, dynamic> json) => SpecificCateList(
    drinks: List<Drink>.from(json["drinks"].map((x) => Drink.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "drinks": List<dynamic>.from(drinks.map((x) => x.toJson())),
  };
}

class Drink {
  String strDrink;
  String strDrinkThumb;
  String idDrink;

  Drink({
    required this.strDrink,
    required this.strDrinkThumb,
    required this.idDrink,
  });

  factory Drink.fromJson(Map<String, dynamic> json) => Drink(
    strDrink: json["strDrink"],
    strDrinkThumb: json["strDrinkThumb"],
    idDrink: json["idDrink"],
  );

  Map<String, dynamic> toJson() => {
    "strDrink": strDrink,
    "strDrinkThumb": strDrinkThumb,
    "idDrink": idDrink,
  };
}
