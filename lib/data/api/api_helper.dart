import 'dart:convert';
import 'package:rest_o/data/model/restaurant_details.dart';
import 'package:rest_o/data/model/restaurant_list.dart';
import 'package:http/http.dart' as http;
import 'package:rest_o/data/model/restaurant_search.dart';

class ApiHelper {
  final String _baseUrl = 'https://restaurant-api.dicoding.dev/';

  Future<RestaurantList> getRestaurantList() async {
    var response = await http.get(_baseUrl + '/list');

    if (response.statusCode == 200) {
      return RestaurantList.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('An exception has occured');
    }
  }

  Future<RestaurantDetails> getRestaurantDetails(String id) async {
    var response = await http.get(_baseUrl + 'detail/' + id);

    if (response.statusCode == 200) {
      return RestaurantDetails.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('An exception has occured');
    }
  }

  Future<RestaurantSearch> searchRestaurants(String query) async {
    var response = await http.get(_baseUrl + 'search?q=' + query);

    if (response.statusCode == 200) {
      return RestaurantSearch.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('An exception has occured');
    }
  }
}
