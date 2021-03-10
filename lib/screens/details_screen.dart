import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:rest_o/data/model/restaurant_details.dart';
import 'package:rest_o/provider/details_provider.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import '../widgets/fnb_selector.dart';
import '../widgets/menu_list.dart';

class DetailsScreen extends StatelessWidget {
  static const String id = 'details_screen';
  final String restaurantId;

  DetailsScreen({@required this.restaurantId});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    Provider.of<DetailsProvider>(context, listen: false)
        .getDetails(restaurantId);

    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Consumer<DetailsProvider>(
            builder: (context, state, _) {
              if (state.stateDetails == DetailsState.HasData) {
                final Restaurant restaurant =
                    state.restaurantsDetails.restaurant;

                return Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.arrow_back),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.all(
                          Radius.circular(16.0),
                        ),
                        child: Hero(
                          tag: 'image_${restaurant.id}',
                          child: CachedNetworkImage(
                            imageUrl:
                                'https://restaurant-api.dicoding.dev/images/medium/${restaurant.pictureId}',
                            progressIndicatorBuilder:
                                (context, url, downloadProgress) => Center(
                                    child: CircularProgressIndicator(
                                        value: downloadProgress.progress)),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 16.0,
                          horizontal: 10.0,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  restaurant.name,
                                  style: Theme.of(context).textTheme.headline5,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.location_on,
                                      size: 24.0,
                                    ),
                                    SizedBox(
                                      width: 2.0,
                                    ),
                                    Text(
                                      restaurant.city,
                                      style:
                                          Theme.of(context).textTheme.headline6,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 4.0,
                                ),
                                SmoothStarRating(
                                  allowHalfRating: true,
                                  starCount: 5,
                                  rating: restaurant.rating,
                                  size: 24,
                                  isReadOnly: true,
                                  color: Theme.of(context).primaryColor,
                                  borderColor: Theme.of(context).primaryColor,
                                ),
                              ],
                            ),
                            IconButton(
                              icon: Icon(state.isRestoFavorited
                                  ? Icons.favorite
                                  : Icons.favorite_outline),
                              color: state.isRestoFavorited
                                  ? Colors.red
                                  : Colors.grey[600],
                              onPressed: () {
                                state.isRestoFavorited =
                                    !state.isRestoFavorited;
                              },
                            ),
                          ],
                        ),
                      ),
                      Container(
                        child: Text(
                          restaurant.description,
                          style: Theme.of(context).textTheme.bodyText1,
                          textAlign: TextAlign.justify,
                        ),
                        margin: EdgeInsets.symmetric(
                          horizontal: 16.0,
                        ),
                      ),
                      SizedBox(
                        height: 16.0,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 16.0,
                          ),
                          FnBSelector(
                            title: 'Food',
                            menuSelected: state.menuSelected,
                            onTap: () {
                              if (state.menuSelected == 'Beverage') {
                                state.menuSelected = 'Food';
                              }
                            },
                          ),
                          SizedBox(
                            width: 8.0,
                          ),
                          FnBSelector(
                            title: 'Beverage',
                            menuSelected: state.menuSelected,
                            onTap: () {
                              if (state.menuSelected == 'Food') {
                                state.menuSelected = 'Beverage';
                              }
                            },
                          ),
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(
                          vertical: 8.0,
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: 8.0,
                        ),
                        width: double.infinity,
                        height: 150.0,
                        child: MenuList(
                          menuSelected: state.menuSelected,
                          foods: restaurant.menus.foods,
                          drinks: restaurant.menus.drinks,
                        ),
                      ),
                    ],
                  ),
                );
              } else if (state.stateDetails == DetailsState.Error) {
                return Column(
                  children: [
                    SizedBox(
                      height: (height / 2) - 150,
                      width: width,
                    ),
                    Lottie.network(
                        'https://assets8.lottiefiles.com/packages/lf20_f1cFsO.json'),
                    Text(
                      state.messageDetails,
                      style: Theme.of(context).textTheme.headline5,
                    ),
                  ],
                );
              } else if (state.stateDetails == DetailsState.Loading) {
                return Column(
                  children: [
                    SizedBox(
                      height: (height / 2) - 50,
                      width: width,
                    ),
                    Lottie.network(
                        'https://assets10.lottiefiles.com/datafiles/kn5W819UTw4eDwEBTOscVxDtsBaRzRSLnlqWen3o/Loading/data.json'),
                  ],
                );
              } else if (state.stateDetails == DetailsState.NoData) {
                return Column(
                  children: [
                    SizedBox(
                      height: (height / 2) - 150,
                      width: width,
                    ),
                    Lottie.network(
                        'https://assets3.lottiefiles.com/packages/lf20_WUEvZP.json'),
                    Text(
                      state.messageDetails,
                      style: Theme.of(context).textTheme.headline5,
                    ),
                  ],
                );
              } else {
                return Center(
                  child: Text(
                    state.messageDetails,
                    style: Theme.of(context).textTheme.headline5,
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
