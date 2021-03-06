import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:rest_o/provider/list_provider.dart';
import 'package:rest_o/screens/favorites_screen.dart';
import 'package:rest_o/screens/settings_screen.dart';
import 'package:rest_o/utils/background_service.dart';
import 'package:rest_o/utils/notification_helper.dart';
import '../widgets/resto_search.dart';
import '../data/model/restaurant_list.dart';
import '../widgets/resto_card.dart';
import '../screens/details_screen.dart';

class HomeScreen extends StatefulWidget {
  static const String id = 'home_screen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final NotificationHelper _notificationHelper = NotificationHelper();
  final BackgroundService _backgroundService = BackgroundService();

  @override
  void initState() {
    super.initState();
    port.listen((_) async => await _backgroundService.someTask());
    _notificationHelper.configureSelectNotificationSubject(context);
  }

  @override
  void dispose() {
    super.dispose();
    selectNotificationSubject.close();
  }

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
        onPressed: () {
          Navigator.pushNamed(context, FavoritesScreen.id);
        },
      ),
    );
  }
}
