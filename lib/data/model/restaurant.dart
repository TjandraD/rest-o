import 'dart:convert';

class Restaurant {
  String id;
  String name;
  String description;
  String pictureId;
  String city;
  double rating;
  List foods;
  List drinks;

  Restaurant({
    this.id,
    this.name,
    this.description,
    this.pictureId,
    this.city,
    this.rating,
    this.foods,
    this.drinks,
  });

  Restaurant.fromJson(Map<String, dynamic> restaurant) {
    id = restaurant['id'];
    name = restaurant['name'];
    description = restaurant['description'];
    pictureId = restaurant['pictureId'];
    city = restaurant['city'];
    rating = restaurant['rating'].toDouble();
    foods = restaurant['menus']['foods'];
    drinks = restaurant['menus']['drinks'];
  }
}

List<Restaurant> parseRestaurant(String json) {
  final List parsed = jsonDecode(json)['restaurants'];
  return parsed.map((json) => Restaurant.fromJson(json)).toList();
}
