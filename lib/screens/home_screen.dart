import 'package:flutter/material.dart';
import '../widgets/resto_search.dart';
import '../data/model/restaurant.dart';
import '../widgets/resto_card.dart';
import '../screens/details_screen.dart';

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
      ),
    );
  }
}
