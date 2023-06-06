import 'dart:convert';

Details detailsFromJson(String str) => Details.fromJson(json.decode(str));

String detailsToJson(Details data) => json.encode(data.toJson());

class Details {
  List<Map<String, String?>> drinks;

  Details({
    required this.drinks,
  });

  factory Details.fromJson(Map<String, dynamic> json) => Details(
    drinks: List<Map<String, String?>>.from(json["drinks"].map((x) => Map.from(x).map((k, v) => MapEntry<String, String?>(k, v)))),
  );

  Map<String, dynamic> toJson() => {
    "drinks": List<dynamic>.from(drinks.map((x) => Map.from(x).map((k, v) => MapEntry<String, dynamic>(k, v)))),
  };
}
