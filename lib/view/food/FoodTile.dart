import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:openfoodfacts/openfoodfacts.dart';

class FoodTile extends StatelessWidget {
  final Product food;
  const FoodTile(this.food);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Text("${food.productName}"),
      ),
    );
  }
}