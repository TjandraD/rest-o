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
