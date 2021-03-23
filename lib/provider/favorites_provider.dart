import 'package:flutter/foundation.dart';
import 'package:rest_o/data/db/db_helper.dart';
import 'package:rest_o/data/model/restaurant_favorites.dart';

enum FavoritesState { Loading, NoData, HasData, Error }

class FavoritesProvider extends ChangeNotifier {
  final DatabaseHelper dbHelper = DatabaseHelper();

  FavoritesProvider() {
    _getList();
  }

  List<RestaurantFavorites> _restaurantsFavorites;
  String _messageFavorites = '';
  FavoritesState _stateFavorites;

  List<RestaurantFavorites> get restaurantsFavorites => _restaurantsFavorites;

  String get messageFavorites => _messageFavorites;

  FavoritesState get stateFavorites => _stateFavorites;

  Future<dynamic> _getList() async {
    try {
      _stateFavorites = FavoritesState.Loading;
      notifyListeners();
      final restaurant = await dbHelper.getFavorites();
      if (restaurant.isEmpty) {
        _stateFavorites = FavoritesState.NoData;
        _messageFavorites = 'Empty Data';
        notifyListeners();
      } else {
        _stateFavorites = FavoritesState.HasData;
        _restaurantsFavorites = restaurant;
        notifyListeners();
      }
    } catch (e) {
      _stateFavorites = FavoritesState.Error;
      _messageFavorites = 'Error $e';
      notifyListeners();
    }
  }
}
