import 'package:flutter/material.dart';
import 'package:rest_o/data/model/restaurant.dart';
import 'package:rest_o/widgets/resto_card.dart';

class HomeScreen extends StatelessWidget {
  static const String id = 'home_screen';

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
        ],
      ),
      body: FutureBuilder(
        future: DefaultAssetBundle.of(context)
            .loadString('assets/data/local_restaurant.json'),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final List<Restaurant> restaurants = parseRestaurant(snapshot.data);

            return ListView.builder(
              itemCount: restaurants.length,
              itemBuilder: (context, index) {
                Restaurant restaurant = restaurants[index];
                return RestoCard(
                  imgUrl: restaurant.pictureId,
                  name: restaurant.name,
                  city: restaurant.city,
                  rating: restaurant.rating,
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
      ),
    );
  }
}

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
              return RestoCard(
                imgUrl: restaurant.pictureId,
                name: restaurant.name,
                city: restaurant.city,
                rating: restaurant.rating,
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
