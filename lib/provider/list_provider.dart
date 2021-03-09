import 'package:flutter/foundation.dart';
import 'package:rest_o/data/api/api_helper.dart';
import 'package:rest_o/data/model/restaurant_list.dart';

enum ResultState { Loading, NoData, HasData, Error }

class ListProvider extends ChangeNotifier {
  final ApiHelper apiHelper;

  ListProvider({@required this.apiHelper});

  RestaurantList _restaurantsList;
  String _messageList = '';
  ResultState _stateList;

  RestaurantList get restaurantsList => _restaurantsList;

  String get messageList => _messageList;

  ResultState get stateList => _stateList;

  Future<dynamic> getList() async {
    try {
      _stateList = ResultState.Loading;
      notifyListeners();
      final restaurant = await apiHelper.getRestaurantList();
      if (restaurant.restaurants.isEmpty) {
        _stateList = ResultState.NoData;
        _messageList = 'Empty Data';
        notifyListeners();
      } else {
        _stateList = ResultState.HasData;
        _restaurantsList = restaurant;
        notifyListeners();
      }
    } catch (e) {
      _stateList = ResultState.Error;
      _messageList = 'Error $e';
      notifyListeners();
    }
  }
}
