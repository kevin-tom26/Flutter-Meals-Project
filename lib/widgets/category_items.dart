import 'package:flutter/material.dart';
import 'package:meals/model/category.dart';
// import 'package:meals/model/meal.dart';
// import 'package:meals/data/dummy_data.dart';
// import 'package:meals/screens/meals.dart';

class CategoryGridItem extends StatelessWidget {
  const CategoryGridItem(
      {super.key, required this.category, required this.onSelected});

  final Category category;
  final void Function() onSelected;

  // List<Meal> _selectedCategory() {
  //   final filteredList = dummyMeals
  //       .where((meal) => meal.categories.contains(category.id))
  //       .toList();
  //   return filteredList;
  // }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onSelected,
      //() {
      //   Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
      //     return MealsScreen(title: category.title, meals: _selectedCategory());
      //   }));
      // },

      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            colors: [
              category.color.withOpacity(0.6),
              category.color.withOpacity(1)
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Text(
          category.title,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.onBackground,
              ),
        ),
      ),
    );
  }
}
