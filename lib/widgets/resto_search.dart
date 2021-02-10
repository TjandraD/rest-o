import 'package:flutter/material.dart';
import 'package:rest_o/data/model/restaurant.dart';
import 'package:rest_o/widgets/resto_card.dart';
import '../screens/details_screen.dart';

class RestaurantSearch extends SearchDelegate<Restaurant> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder(
      future: DefaultAssetBundle.of(context)
          .loadString('assets/data/local_restaurant.json'),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final List<Restaurant> restaurants = parseRestaurant(snapshot.data)
              .where((r) => r.name.toLowerCase().contains(query))
              .toList();

          return ListView.builder(
            itemCount: restaurants.length,
            itemBuilder: (context, index) {
              Restaurant restaurant = restaurants[index];
              return GestureDetector(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    DetailsScreen.id,
                    arguments: restaurant,
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
        } else if (snapshot.hasError) {
          return Center(
            child: Icon(Icons.error),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder(
      future: DefaultAssetBundle.of(context)
          .loadString('assets/data/local_restaurant.json'),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final List<Restaurant> restaurants = parseRestaurant(snapshot.data)
              .where((r) => r.name.toLowerCase().contains(query))
              .toList();

          return ListView.builder(
            itemCount: restaurants.length,
            itemBuilder: (context, index) {
              Restaurant restaurant = restaurants[index];
              return ListTile(
                title: Text(restaurant.name),
                onTap: () {
                  query = restaurant.name.toLowerCase();
                  showResults(context);
                },
              );
            },
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Column(
              children: [
                Icon(Icons.error),
                Text('Couldn\'t load data!'),
              ],
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
