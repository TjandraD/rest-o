import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:rest_o/data/api/api_helper.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter/services.dart';
import 'package:rest_o/data/model/restaurant_details.dart';
import 'package:rest_o/data/model/restaurant_list.dart';

class MockClient extends Mock implements ApiHelper {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  group("API Helper test", () {
    MockClient apiHelper;

    setUp(() {
      apiHelper = MockClient();
    });

    test('Get restaurants list', () async {
      when(apiHelper.getRestaurantList()).thenAnswer((_) async {
        var result =
            await rootBundle.loadString('assets/json/restaurant_list.json');

        return RestaurantList.fromJson(jsonDecode(result));
      });

      var response = await apiHelper.getRestaurantList();
      var restaurant = response.restaurants[0];
      expect(restaurant.name, "Melting Pot");
    });

    test('Get restaurant from id', () async {
      String id = "rqdv5juczeskfw1e867";
      when(apiHelper.getRestaurantDetails(id)).thenAnswer((_) async {
        var result =
            await rootBundle.loadString('assets/json/restaurant_detail.json');

        return RestaurantDetails.fromJson(jsonDecode(result));
      });

      final response = await apiHelper.getRestaurantDetails(id);
      final restaurant = response.restaurant;
      expect(restaurant.name, "Melting Pot");
    });
  });
}
