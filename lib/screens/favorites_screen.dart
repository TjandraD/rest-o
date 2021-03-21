import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:rest_o/data/model/restaurant_list.dart';
import 'package:rest_o/provider/list_provider.dart';
import 'package:rest_o/screens/settings_screen.dart';
import 'package:rest_o/widgets/resto_card.dart';
import 'package:rest_o/widgets/resto_search.dart';

import 'details_screen.dart';

class FavoritesScreen extends StatelessWidget {
  static const String id = 'favorites_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Rest-O',
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: RestaurantSearch(),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              Navigator.pushNamed(context, SettingsScreen.id);
            },
          ),
        ],
      ),
      body: Consumer<ListProvider>(
        builder: (context, state, _) {
          if (state.stateList == ListState.Loading) {
            return Center(
              child: Lottie.network(
                'https://assets10.lottiefiles.com/datafiles/kn5W819UTw4eDwEBTOscVxDtsBaRzRSLnlqWen3o/Loading/data.json',
                width: 100.0,
                height: 100.0,
              ),
            );
          } else if (state.stateList == ListState.HasData) {
            final List<Restaurant> restaurants =
                state.restaurantsList.restaurants;

            return ListView.builder(
              itemCount: restaurants.length,
              itemBuilder: (context, index) {
                Restaurant restaurant = restaurants[index];
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
          } else if (state.stateList == ListState.NoData) {
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
                    state.messageList,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ],
              ),
            );
          } else if (state.stateList == ListState.Error) {
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
                    state.messageList,
                    style: Theme.of(context).textTheme.headline5,
                  ),
                ],
              ),
            );
          } else {
            return Center(
              child: Text(
                state.messageList,
                style: Theme.of(context).textTheme.headline5,
              ),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.favorite_outline),
        backgroundColor: Colors.red[300],
        onPressed: () {},
      ),
    );
  }
}
