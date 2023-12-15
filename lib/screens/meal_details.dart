import 'package:flutter/material.dart';
import 'package:meals/model/meal.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/provider/favourite_meal_provider.dart';

class MealDetailScreen extends ConsumerWidget {
  const MealDetailScreen({super.key, required this.meals});

  final Meal meals;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final FavouriteMeals = ref.watch(favouriteProvider);

    final isFavourite = FavouriteMeals.contains(meals);

    return Scaffold(
        appBar: AppBar(
          title: Text(meals.title),
          actions: [
            IconButton(
                onPressed: () {
                  final favSnakBar = ref
                      .read(favouriteProvider.notifier)
                      .addToFavourite(meals);
                  ScaffoldMessenger.of(context).clearSnackBars();
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(favSnakBar
                          ? 'Meal added to Favourites'
                          : 'Meal removed from favourites')));
                },
                icon: Icon(isFavourite ? Icons.star : Icons.star_border)),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Image.network(
                meals.imageUrl,
                width: double.infinity,
                height: 300,
                fit: BoxFit.cover,
              ),
              const SizedBox(
                height: 14,
              ),
              Text(
                "Ingredients",
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(color: Theme.of(context).colorScheme.primary),
              ),
              const SizedBox(
                height: 14,
              ),
              for (final ingredients in meals.ingredients)
                Text(
                  ingredients,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground),
                ),
              const SizedBox(
                height: 14,
              ),
              Text(
                "Steps",
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(color: Theme.of(context).colorScheme.primary),
              ),
              const SizedBox(
                height: 6,
              ),
              for (final steps in meals.steps)
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                  child: Text(
                    steps,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Theme.of(context).colorScheme.onBackground),
                  ),
                ),
            ],
          ),
        ));
  }
}
