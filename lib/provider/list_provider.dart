import 'package:connectivity/connectivity.dart';
import 'package:flutter/foundation.dart';
import 'package:rest_o/data/api/api_helper.dart';
import 'package:rest_o/data/model/restaurant_list.dart';

enum ListState { Loading, NoData, HasData, Error }

class ListProvider extends ChangeNotifier {
  final ApiHelper apiHelper;

  ListProvider({@required this.apiHelper}) {
    _getList();
  }

  RestaurantList _restaurantsList;
  String _messageList = '';
  ListState _stateList;

  RestaurantList get restaurantsList => _restaurantsList;

  String get messageList => _messageList;

  ListState get stateList => _stateList;

  Future<dynamic> _getList() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      try {
        _stateList = ListState.Loading;
        notifyListeners();
        final restaurant = await apiHelper.getRestaurantList();
        if (restaurant.restaurants.isEmpty) {
          _stateList = ListState.NoData;
          _messageList = 'Empty Data';
          notifyListeners();
        } else {
          _stateList = ListState.HasData;
          _restaurantsList = restaurant;
          notifyListeners();
        }
      } catch (e) {
        _stateList = ListState.Error;
        _messageList = 'Error $e';
        notifyListeners();
      }
    } else if (connectivityResult == ConnectivityResult.none) {
      _stateList = ListState.Error;
      _messageList =
          'No connection detected! Please check your internet connection';
      notifyListeners();
    } else {
      _stateList = ListState.Loading;
      notifyListeners();
    }
  }
}
