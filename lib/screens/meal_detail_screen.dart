import 'package:flutter/material.dart';
import 'package:meals/models/dummy_data.dart';

class MealDetailScreen extends StatelessWidget {
  static const route = '/categories-meal/meal-detail-screen';
  Widget _buildSectionTitle(BuildContext context, String title) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      child: Text(
        title,
        style: Theme.of(context).textTheme.title,
      ),
    );
  }

  Widget _buildContainer(Widget child, double height) {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 5,vertical: 10),
        width: double.infinity,
        height: height,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            color: Colors.white,
            borderRadius: BorderRadius.circular(15)),
        child: child);
  }

  @override
  Widget build(BuildContext context) {
    final mealId = ModalRoute.of(context).settings.arguments as String;
    final selectedMeal =
        DUMMY_MEALS.firstWhere((element) => element.id == mealId);
    return Scaffold(
      appBar: AppBar(
        title: Text('Meal'),
      ),
      body: SingleChildScrollView(
              child: Column(
          children: [
            Container(
              height: 300,
              width: double.infinity,
              child: Image.network(
                selectedMeal.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            _buildSectionTitle(context, 'Ingredients'),
            _buildContainer(
                ListView.builder(
                  itemBuilder: (ctx, index) {
                    return Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            gradient: LinearGradient(
                                colors: [
                                  Theme.of(context).accentColor.withOpacity(0.7),
                                  Theme.of(context).accentColor
                                ],
                                begin: Alignment.bottomLeft,
                                end: Alignment.topRight)),
                        width: 150,
                        height: 120,
                        margin: EdgeInsets.all(20),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              selectedMeal.ingredients[index],
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ));
                  },
                  scrollDirection: Axis.horizontal,
                  itemCount: selectedMeal.ingredients.length,
                ),
                125),
            _buildSectionTitle(context, 'Steps'),
            _buildContainer(ListView.builder(itemBuilder: (ctx, index) {
              return Column(
                children: [
                  ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Theme.of(context).accentColor,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: FittedBox(child: Text('# ${index + 1}')),
                      ),
                    ),
                    title: Text(selectedMeal.steps[index],style: TextStyle(fontSize: 16),),
                  ),
                  Divider()
                ],
              );
            },itemCount: selectedMeal.steps.length,), 300)
          ],
        ),
      ),
    );
  }
}
