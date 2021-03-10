import 'package:flutter/foundation.dart';
import 'package:rest_o/data/api/api_helper.dart';
import 'package:rest_o/data/model/restaurant_details.dart';

enum DetailsState { Loading, NoData, HasData, Error }

class DetailsProvider extends ChangeNotifier {
  final ApiHelper apiHelper;

  DetailsProvider({@required this.apiHelper});

  RestaurantDetails _restaurantDetails;
  String _messageDetails = '';
  DetailsState _stateDetails;

  RestaurantDetails get restaurantsDetails => _restaurantDetails;

  String get messageDetails => _messageDetails;

  DetailsState get stateDetails => _stateDetails;

  Future<dynamic> getDetails(String id) async {
    try {
      _stateDetails = DetailsState.Loading;
      notifyListeners();
      final restaurant = await apiHelper.getRestaurantDetails(id);

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
  }

  bool _isRestoFavorited = false;
  String _menuSelected = 'Food';

  bool get isRestoFavorited => _isRestoFavorited;
  String get menuSelected => _menuSelected;

  set isRestoFavorited(bool newValue) {
    _isRestoFavorited = newValue;
    notifyListeners();
  }

  set menuSelected(String newValue) {
    _menuSelected = newValue;
    notifyListeners();
  }
}