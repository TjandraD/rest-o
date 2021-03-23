import 'package:flutter_test/flutter_test.dart';
import 'package:rest_o/data/api/api_helper.dart';

void main() {
  group("API Helper test", () {
    ApiHelper apiHelper;

    setUp(() {
      apiHelper = ApiHelper();
    });

    test('Get restaurants list', () async {
      final response = await apiHelper.getRestaurantList();
      var restaurant = response.restaurants[0];
      expect(restaurant.name, "Melting Pot");
    });

    test('Get restaurant from id', () async {
      String id = "rqdv5juczeskfw1e867";
      final response = await apiHelper.getRestaurantList();
      final restaurants =
          response.restaurants.where((resto) => resto.id.contains(id)).toList();
      var restaurant = restaurants[0];
      expect(restaurant.name, "Melting Pot");
    });
  });
}
