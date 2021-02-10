import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:rest_o/data/model/restaurant.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import '../widgets/fnb_selector.dart';
import '../widgets/menu_list.dart';

class DetailsScreen extends StatefulWidget {
  static const String id = 'details_screen';
  final Restaurant restaurant;

  DetailsScreen({@required this.restaurant});

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  bool isRestoFavorited = false;
  String menuSelected = 'Food';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.restaurant.name),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.all(
                  Radius.circular(16.0),
                ),
                child: Hero(
                  tag: 'image_${widget.restaurant.id}',
                  child: CachedNetworkImage(
                    imageUrl: widget.restaurant.pictureId,
                    progressIndicatorBuilder:
                        (context, url, downloadProgress) => Center(
                            child: CircularProgressIndicator(
                                value: downloadProgress.progress)),
                    errorWidget: (context, url, error) => Icon(Icons.error),
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
                          widget.restaurant.name,
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
                              widget.restaurant.city,
                              style: Theme.of(context).textTheme.headline6,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 4.0,
                        ),
                        SmoothStarRating(
                          allowHalfRating: true,
                          starCount: 5,
                          rating: widget.restaurant.rating,
                          size: 24,
                          isReadOnly: true,
                          color: Theme.of(context).primaryColor,
                          borderColor: Theme.of(context).primaryColor,
                        ),
                      ],
                    ),
                    IconButton(
                      icon: Icon(isRestoFavorited
                          ? Icons.favorite
                          : Icons.favorite_outline),
                      color: isRestoFavorited ? Colors.red : Colors.grey[600],
                      onPressed: () {
                        setState(() {
                          isRestoFavorited = !isRestoFavorited;
                        });
                      },
                    ),
                  ],
                ),
              ),
              Container(
                child: Text(
                  widget.restaurant.description,
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
                    menuSelected: menuSelected,
                    onTap: () {
                      setState(() {
                        if (menuSelected == 'Beverage') {
                          menuSelected = 'Food';
                        }
                      });
                    },
                  ),
                  SizedBox(
                    width: 8.0,
                  ),
                  FnBSelector(
                    title: 'Beverage',
                    menuSelected: menuSelected,
                    onTap: () {
                      setState(() {
                        if (menuSelected == 'Food') {
                          menuSelected = 'Beverage';
                        }
                      });
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
                  menuSelected: menuSelected,
                  foods: widget.restaurant.foods,
                  drinks: widget.restaurant.drinks,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
