import 'package:flutter/material.dart';
import 'package:meals/models/dummy_data.dart';
import 'package:meals/widgets/meal_item.dart';

import '../models/meal.dart';

class CategoryMealsScreen extends StatelessWidget {
  static const route = '/categories-meal';
  @override
  Widget build(BuildContext context) {
    final rootArgs =
        ModalRoute.of(context).settings.arguments as Map<String, String>;
    final categoryTitle = rootArgs['title'];
    final categoryId = rootArgs['id'];

    List<Meal> mealsForTheCategory = DUMMY_MEALS.where((meal) {
      List<String> categories = meal.categories;
      return categories.contains(categoryId);
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle),
      ),
      body: ListView.builder(
        itemBuilder: (ctx, index) {
          return MealItem(
            mealId: mealsForTheCategory[index].id,
            affordability: mealsForTheCategory[index].affordability,
            complexity: mealsForTheCategory[index].complexity,
            duration: mealsForTheCategory[index].duration,
            title: mealsForTheCategory[index].title,
            imageUrl: mealsForTheCategory[index].imageUrl,
          );
        },
        itemCount: mealsForTheCategory.length,
      ),
    );
  }
}
