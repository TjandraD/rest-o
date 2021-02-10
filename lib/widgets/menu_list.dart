import 'package:flutter/material.dart';

class MenuList extends StatelessWidget {
  final String menuSelected;
  final List foods;
  final List drinks;

  MenuList({
    @required this.menuSelected,
    @required this.foods,
    @required this.drinks,
  });

  @override
  Widget build(BuildContext context) {
    if (menuSelected == 'Food') {
      return ListView(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        children: foods.map((food) {
          return Container(
            margin: EdgeInsets.symmetric(
              horizontal: 8.0,
            ),
            padding: EdgeInsets.all(
              4.0,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(10.0),
              ),
              border: Border.all(color: Colors.grey),
            ),
            width: 100.0,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/food_icon.jpg',
                    width: 80.0,
                  ),
                  Text(
                    food['name'],
                    style: Theme.of(context).textTheme.bodyText2,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      );
    } else {
      return ListView(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        children: drinks.map((drink) {
          return Container(
            margin: EdgeInsets.symmetric(
              horizontal: 8.0,
            ),
            padding: EdgeInsets.all(
              4.0,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(10.0),
              ),
              border: Border.all(color: Colors.grey),
            ),
            width: 100.0,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/beverage_icon.png',
                    width: 80.0,
                  ),
                  SizedBox(
                    height: 4.0,
                  ),
                  Text(
                    drink['name'],
                    style: Theme.of(context).textTheme.bodyText2,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      );
    }
  }
}
