import 'package:flutter/material.dart';
import '../data/model/restaurant.dart';
import 'resto_card.dart';
import '../screens/details_screen.dart';

class MainRestoList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
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
    );
  }
}
