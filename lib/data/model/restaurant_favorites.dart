import 'package:rest_o/data/model/restaurant_details.dart';

class RestaurantFavorites {
  RestaurantFavorites({
    this.id,
    this.name,
    this.description,
    this.city,
    this.pictureId,
    this.rating,
  });

  String id;
  String name;
  String description;
  String pictureId;
  String city;
  double rating;

  factory RestaurantFavorites.fromJson(Map<String, dynamic> json) =>
      RestaurantFavorites(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        pictureId: json["pictureId"],
        city: json["city"],
        rating: json["rating"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "pictureId": pictureId,
        "city": city,
        "rating": rating,
      };

  factory RestaurantFavorites.fromRestaurant(RestaurantDetails restaurant) =>
      RestaurantFavorites(
        id: restaurant.restaurant.id,
        name: restaurant.restaurant.name,
        description: restaurant.restaurant.description,
        pictureId: restaurant.restaurant.pictureId,
        city: restaurant.restaurant.city,
        rating: restaurant.restaurant.rating,
      );
}
