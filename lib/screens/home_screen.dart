import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rest_o/provider/list_provider.dart';
import '../widgets/resto_search.dart';
import '../data/model/restaurant_list.dart';
import '../widgets/resto_card.dart';
import '../screens/details_screen.dart';

class HomeScreen extends StatelessWidget {
  static const String id = 'home_screen';

  @override
  Widget build(BuildContext context) {
    Provider.of<ListProvider>(context, listen: false).getList();
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
        ],
      ),
      body: Consumer<ListProvider>(
        builder: (context, state, _) {
          if (state.stateList == ResultState.Loading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state.stateList == ResultState.HasData) {
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
          } else if (state.stateList == ResultState.NoData) {
            return Center(
              child: Text(
                state.messageList,
                style: Theme.of(context).textTheme.headline6,
              ),
            );
          } else if (state.stateList == ResultState.Error) {
            return Center(
              child: Text(
                state.messageList,
                style: Theme.of(context).textTheme.headline5,
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
    );
  }
}
