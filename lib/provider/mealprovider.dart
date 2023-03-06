// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:meal_app/models/category.dart';

import '../dummy_data.dart';
import '../models/meal.dart';

class MealProvider with ChangeNotifier {
  // start favorite
  List<Meal> favoriteMeals = [];
  List<String> prefsMealId = [];

  void toggleFavorite(String mealId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    /* هنا بنختبر لما اضغط عالزرار والقيمه الا دي ترجع بنشوفه موجود فالفيفورت ولا لا لو موجود هيبقا له اندكس يعني هيبقي الاندكس صفر او اكتر لو ملوش هيبقي بسالب واحد */
    final existingIndex = favoriteMeals.indexWhere((meal) => meal.id == mealId);
    //لو اكبر من الصفر يعني له اندكس يبقا موجود فالفيفورت سكرين فهنشيه
    if (existingIndex >= 0) {
      favoriteMeals.removeAt(existingIndex);
      prefsMealId.remove(mealId);
    }
    //لو الاندكس سالب يبقا مش موجود قبل كدا فهنضيفه
    else {
      favoriteMeals.add(DUMMY_MEALS.firstWhere((meal) => meal.id == mealId));
      prefsMealId.add(mealId);
    }
    notifyListeners();
    prefs.setStringList('prefsMealId', prefsMealId);
  }

  bool isMealFavorite(String id) {
    return favoriteMeals.any((meal) => meal.id == id) ||
        prefsMealId.any((meal) => meal == id);
  }

  // end favorite

  // start filter
  List<Meal> availableMeals = DUMMY_MEALS;
  List<Category> availableCategory = [];

  Map<String, bool> filters = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegatarian': false,
  };

  void setFilters() async {
    availableMeals = DUMMY_MEALS.where((meal) {
      if (filters['gluten']! && !meal.isGlutenFree) {
        return false;
      }
      if (filters['lactose']! && !meal.isLactoseFree) {
        return false;
      }
      if (filters['vegan']! && !meal.isVegan) {
        return false;
      }
      if (filters['vegatarian']! && !meal.isVegetarian) {
        return false;
      }
      return true;
    }).toList();

    List<Category> ac = [];
    // بنعدي ع الوجبه الاول
    availableMeals.forEach((meal) {
      // بندخل جوا التصنيفات اللي فالوجبه
      meal.categories.forEach((catID) {
        // بنعدي ع التصنيفات اللي فالتطبيق كله عشان نقارن
        DUMMY_CATEGORIES.forEach((cat) {
          // بنقارن تصنيف الوجبه الواحده زي  التصنيف اللي برا ولا لا عشان نقدر نتحكم
          if (cat.id == catID) {
            if (!ac.any((cat) => cat.id == catID)) {
              ac.add(cat);
            }
          }
        });
      });
    });
    availableCategory = ac;
    notifyListeners();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('gluten', filters['gluten']!);
    prefs.setBool('lactose', filters['lactose']!);
    prefs.setBool('vegan', filters['vegan']!);
    prefs.setBool('vegatarian', filters['vegatarian']!);
  }

  // end filter

  void getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // to get filters
    filters['gluten'] = prefs.getBool('gluten') ?? false;
    filters['lactose'] = prefs.getBool('lactose') ?? false;
    filters['vegan'] = prefs.getBool('vegan') ?? false;
    filters['vegatarian'] = prefs.getBool('vegatarian') ?? false;

    setFilters();

    // to get favoriteMeals
    prefsMealId = prefs.getStringList('prefsMealId') ?? [];
    for (var mealId in prefsMealId) {
      final existingIndex =
          favoriteMeals.indexWhere((meal) => meal.id == mealId);
      if (existingIndex < 0) {
        favoriteMeals.add(DUMMY_MEALS.firstWhere((meal) => meal.id == mealId));
      }
    }
    List<Meal> fm = [];
    favoriteMeals.forEach((favMeals) {
      availableMeals.forEach((avMeals) {
        if (favMeals.id == avMeals.id) fm.add(favMeals);
      });
    });
    favoriteMeals = fm;
    notifyListeners();
  }
}
