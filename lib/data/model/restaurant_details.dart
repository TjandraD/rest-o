class RestaurantDetails {
  RestaurantDetails({
    this.error,
    this.message,
    this.restaurant,
  });

  bool error;
  String message;
  Restaurant restaurant;

  factory RestaurantDetails.fromJson(Map<String, dynamic> json) =>
      RestaurantDetails(
        error: json["error"],
        message: json["message"],
        restaurant: Restaurant.fromJson(json["restaurant"]),
      );
}

class Restaurant {
  Restaurant({
    this.id,
    this.name,
    this.description,
    this.city,
    this.address,
    this.pictureId,
    this.categories,
    this.menus,
    this.rating,
    this.customerReviews,
  });

  String id;
  String name;
  String description;
  String city;
  String address;
  String pictureId;
  List<Map> categories;
  Menus menus;
  double rating;
  List<CustomerReview> customerReviews;

  factory Restaurant.fromJson(Map<String, dynamic> json) => Restaurant(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        city: json["city"],
        address: json["address"],
        pictureId: json["pictureId"],
        categories: json['categories'],
        menus: Menus.fromJson(json["menus"]),
        rating: json["rating"].toDouble(),
        customerReviews: List<CustomerReview>.from(
            json["customerReviews"].map((x) => CustomerReview.fromJson(x))),
      );
}

class CustomerReview {
  CustomerReview({
    this.name,
    this.review,
    this.date,
  });

  String name;
  String review;
  String date;

  factory CustomerReview.fromJson(Map<String, dynamic> json) => CustomerReview(
        name: json["name"],
        review: json["review"],
        date: json["date"],
      );
}

class Menus {
  Menus({
    this.foods,
    this.drinks,
  });

  List<Map> foods;
  List<Map> drinks;

  factory Menus.fromJson(Map<String, dynamic> json) => Menus(
        foods: json['foods'],
        drinks: json['drinks'],
      );
}
