import 'package:connectivity/connectivity.dart';
import 'package:flutter/foundation.dart';
import 'package:rest_o/data/api/api_helper.dart';
import 'package:rest_o/data/db/db_helper.dart';
import 'package:rest_o/data/model/restaurant_details.dart';

enum DetailsState { Loading, NoData, HasData, Error }

class DetailsProvider extends ChangeNotifier {
  final ApiHelper apiHelper;
  final DatabaseHelper _db = DatabaseHelper();

  DetailsProvider({@required this.apiHelper});

  RestaurantDetails _restaurantDetails;
  String _messageDetails = '';
  DetailsState _stateDetails;

  RestaurantDetails get restaurantsDetails => _restaurantDetails;

  String get messageDetails => _messageDetails;

  DetailsState get stateDetails => _stateDetails;

  Future<dynamic> getDetails(String id) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      try {
        _stateDetails = DetailsState.Loading;
        final restaurant = await apiHelper.getRestaurantDetails(id);
        notifyListeners();

        if (restaurant.restaurant == null) {
          _stateDetails = DetailsState.NoData;
          _messageDetails = 'Empty Data';
          notifyListeners();
        } else {
          _stateDetails = DetailsState.HasData;
          _restaurantDetails = restaurant;
          notifyListeners();
        }
      } catch (e) {
        _stateDetails = DetailsState.Error;
        _messageDetails = 'Error $e';
        notifyListeners();
      }
    } else if (connectivityResult == ConnectivityResult.none) {
      _stateDetails = DetailsState.Error;
      _messageDetails =
          'No connection detected! Please check your internet connection';
      notifyListeners();
    } else {
      _stateDetails = DetailsState.Loading;
      notifyListeners();
    }
  }

  bool _isRestoFavorited = false;
  String _menuSelected = 'Food';

  bool get isRestoFavorited => _isRestoFavorited;
  String get menuSelected => _menuSelected;

  Future<dynamic> getRestoFavorited(String id) async {
    var result = await _db.getFavoriteById(id);
    _isRestoFavorited = result.isNotEmpty;
    notifyListeners();
  }

  Future<void> _addFavResto(RestaurantDetails restaurant) async {
    try {
      await _db.insertFavorite(restaurant);
      _isRestoFavorited = true;
    } catch (e) {
      print(">>> Failed insert to favorites");
    }
  }

  Future<void> _removeFavResto(String id) async {
    try {
      await _db.removeFavorite(id);
      _isRestoFavorited = false;
    } catch (e) {
      print(">>> Failed remove from favorites");
    }
  }

  Future<void> onFavClicked(RestaurantDetails restaurant, String id) async {
    if (_isRestoFavorited) {
      await _removeFavResto(id);
    } else {
      await _addFavResto(restaurant);
    }
    notifyListeners();
  }

  set menuSelected(String newValue) {
    _menuSelected = newValue;
    notifyListeners();
  }
}
