import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:rest_o/data/model/restaurant_favorites.dart';
import 'package:rest_o/provider/favorites_provider.dart';
import 'package:rest_o/widgets/resto_card.dart';
import 'details_screen.dart';

class FavoritesScreen extends StatelessWidget {
  static const String id = 'favorites_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Favorites Resto',
        ),
      ),
      body: Consumer<FavoritesProvider>(
        builder: (context, state, _) {
          if (state.stateFavorites == FavoritesState.Loading) {
            return Center(
              child: Lottie.network(
                'https://assets10.lottiefiles.com/datafiles/kn5W819UTw4eDwEBTOscVxDtsBaRzRSLnlqWen3o/Loading/data.json',
                width: 100.0,
                height: 100.0,
              ),
            );
          } else if (state.stateFavorites == FavoritesState.HasData) {
            final List<RestaurantFavorites> restaurants =
                state.restaurantsFavorites;

            return ListView.builder(
              itemCount: restaurants.length,
              itemBuilder: (context, index) {
                RestaurantFavorites restaurant = restaurants[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      DetailsScreen.id,
                      arguments: restaurant.id,
                    );
                  },
                  child: RestoCard(
                    id: restaurant.id,
                    imgUrl: restaurant.pictureId,
                    name: restaurant.name,
                    city: restaurant.city,
                    rating: restaurant.rating,
                  ),
                );
              },
            );
          } else if (state.stateFavorites == FavoritesState.NoData) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.network(
                    'https://assets3.lottiefiles.com/packages/lf20_WUEvZP.json',
                    width: 100.0,
                    height: 100.0,
                  ),
                  Text(
                    state.messageFavorites,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ],
              ),
            );
          } else if (state.stateFavorites == FavoritesState.Error) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.asset(
                    'assets/json/error_animation.json',
                    width: 100.0,
                    height: 100.0,
                  ),
                  Text(
                    state.messageFavorites,
                    style: Theme.of(context).textTheme.headline5,
                  ),
                ],
              ),
            );
          } else {
            return Center(
              child: Text(
                state.messageFavorites,
                style: Theme.of(context).textTheme.headline5,
              ),
            );
          }
        },
      ),
    );
  }
}
