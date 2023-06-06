class SpecificCateList {
  List<Drinks>? drinks;

  SpecificCateList({this.drinks});

  SpecificCateList.fromJson(Map<String, dynamic> json) {
    if (json['drinks'] != null) {
      drinks = <Drinks>[];
      json['drinks'].forEach((v) {
        drinks!.add(new Drinks.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.drinks != null) {
      data['drinks'] = this.drinks!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Drinks {
  String? strDrink;
  String? strDrinkThumb;
  String? idDrink;

  Drinks({this.strDrink, this.strDrinkThumb, this.idDrink});

  Drinks.fromJson(Map<String, dynamic> json) {
    strDrink = json['strDrink'];
    strDrinkThumb = json['strDrinkThumb'];
    idDrink = json['idDrink'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['strDrink'] = this.strDrink;
    data['strDrinkThumb'] = this.strDrinkThumb;
    data['idDrink'] = this.idDrink;
    return data;
  }
}