import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/screens/catagories.dart';
import 'package:meals/screens/meal_filter_Screen.dart';
import 'package:meals/screens/meals.dart';
import 'package:meals/widgets/meal_drawer.dart';
import 'package:meals/provider/favourite_meal_provider.dart';
import 'package:meals/provider/filter_provider.dart';

const kFilterValues = {
  Filter.gluttenFree: false,
  Filter.lactoseFree: false,
  Filter.vegettarian: false,
  Filter.vegan: false
};

class TabScreen extends ConsumerStatefulWidget {
  const TabScreen({super.key});

  @override
  ConsumerState<TabScreen> createState() => _TabScreenState();
}

class _TabScreenState extends ConsumerState<TabScreen> {
  var _selectedPageIndex = 0;

  void _selectedPage(index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void _setDrawerNavigation(String indentifier) async {
    Navigator.of(context).pop();
    if (indentifier == 'filter') {
      await Navigator.of(context).push<Map<Filter, bool>>(
          MaterialPageRoute(builder: (ctx) => const FilterScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    final availableMeals = ref.watch(filterMealProvider);
    Widget activePage = CategoriesScreen(
      availableMeal: availableMeals,
    );
    String activePageTitle = 'Categories';

    if (_selectedPageIndex == 1) {
      final favouriteMeal = ref.watch(favouriteProvider);
      activePage = MealsScreen(
        meals: favouriteMeal,
      );
      activePageTitle = 'Favourites';
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
      ),
      drawer: MealDrawer(
        onSelecting: _setDrawerNavigation,
      ),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
          onTap: _selectedPage,
          currentIndex: _selectedPageIndex,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.set_meal), label: 'Categories'),
            BottomNavigationBarItem(icon: Icon(Icons.star), label: "Favourites")
          ]),
    );
  }
}
