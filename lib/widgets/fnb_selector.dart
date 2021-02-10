import 'package:flutter/material.dart';

class FnBSelector extends StatelessWidget {
  final String title;
  final String menuSelected;
  final Function onTap;

  FnBSelector({
    @required this.title,
    @required this.menuSelected,
    @required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: menuSelected == title
              ? Theme.of(context).accentColor.withOpacity(0.75)
              : Colors.white,
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.all(Radius.circular(30.0)),
        ),
        padding: EdgeInsets.all(12.0),
        child: Text(
          title,
          style: Theme.of(context).textTheme.bodyText1.copyWith(
              color: menuSelected == title ? Colors.white : Colors.grey),
        ),
      ),
    );
  }
}
