class Restaurant {
  String id;
  String name;
  String description;
  String pictureId;
  String city;
  double rating;
  List<Map> foods;
  List<Map> drinks;

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
    rating = restaurant['rating'];
    foods = restaurant['menus']['foods'];
    drinks = restaurant['menus']['drinks'];
  }
}
