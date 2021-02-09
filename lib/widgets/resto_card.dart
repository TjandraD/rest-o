import 'package:flutter/material.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:cached_network_image/cached_network_image.dart';

class RestoCard extends StatelessWidget {
  final String imgUrl;
  final String name;
  final String city;
  final double rating;

  RestoCard({
    @required this.imgUrl,
    @required this.name,
    @required this.city,
    @required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 8.0,
      ),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.75),
        borderRadius: BorderRadius.all(Radius.circular(16.0)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.grey.withOpacity(0.6),
            offset: const Offset(4, 4),
            blurRadius: 16,
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16.0),
              bottomLeft: Radius.circular(16.0),
            ),
            child: CachedNetworkImage(
              imageUrl: imgUrl,
              height: 120.0,
              width: 160.0,
              fit: BoxFit.cover,
              progressIndicatorBuilder: (context, url, downloadProgress) =>
                  Center(
                      child: CircularProgressIndicator(
                          value: downloadProgress.progress)),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
          ),
          SizedBox(
            width: 12.0,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 4.0,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.location_on,
                    size: 16.0,
                  ),
                  SizedBox(
                    width: 2.0,
                  ),
                  Text(
                    city,
                  ),
                ],
              ),
              SizedBox(
                height: 4.0,
              ),
              SmoothStarRating(
                allowHalfRating: true,
                starCount: 5,
                rating: rating,
                size: 20,
                color: Theme.of(context).primaryColor,
                borderColor: Theme.of(context).primaryColor,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
