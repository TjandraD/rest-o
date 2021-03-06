import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:rest_o/data/api/api_helper.dart';
import 'package:rest_o/data/model/restaurant_search.dart';
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
      future: ApiHelper().searchRestaurants(query),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final List<Restaurant> restaurants = snapshot.data.restaurants;

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
        } else if (snapshot.hasError) {
          return Center(
            child: Lottie.network(
                'https://assets8.lottiefiles.com/packages/lf20_f1cFsO.json'),
          );
        } else {
          return Center(
            child: Lottie.network(
                'https://assets10.lottiefiles.com/datafiles/kn5W819UTw4eDwEBTOscVxDtsBaRzRSLnlqWen3o/Loading/data.json'),
          );
        }
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }
}
