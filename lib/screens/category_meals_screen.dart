import 'package:flutter/material.dart';
import 'package:meals/widgets/meal_item.dart';

import '../models/meal.dart';

class CategoryMealsScreen extends StatefulWidget {
  static const route = '/categories-meal';
  final availableMeals;
  CategoryMealsScreen(this.availableMeals);

  @override
  _CategoryMealsScreenState createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
  String categoryTitle;
  String categoryId;
  List<Meal> mealsForTheCategory;
  var _stateInitialize = false;

  void _removeMeal(String mealId) {
    setState(() {
      mealsForTheCategory.removeWhere((element) => element.id == mealId);
    });
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    if (!_stateInitialize) {
      final rootArgs =
          ModalRoute.of(context).settings.arguments as Map<String, String>;
      categoryTitle = rootArgs['title'];
      categoryId = rootArgs['id'];

      mealsForTheCategory = widget.availableMeals.where((meal) {
        List<String> categories = meal.categories;
        return categories.contains(categoryId);
      }).toList();
      _stateInitialize = true;
    }

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
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
