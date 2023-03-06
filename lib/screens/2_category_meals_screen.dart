// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:meal_app/models/meal.dart';

import '../provider/language_provider.dart';
import '../provider/mealprovider.dart';
import '../widgets/meal_item.dart';

/* هنا بنظهر الوجبه اللي المستخدم فتحها */
class CategoryMealsScreen extends StatefulWidget {
  static const routName = 'category_meal';

  const CategoryMealsScreen({Key? key}) : super(key: key);

  @override
  State<CategoryMealsScreen> createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
  String categoryId = '';
  List<Meal> displayesMeals = [];

  @override
  void didChangeDependencies() {
    // get availableMeal by provider
    final List<Meal> availableMeals =
        Provider.of<MealProvider>(context, listen: true).availableMeals;
    //استقبلنا البيانات اللي جايه من الcategoriesscreen
    final routArg =
        ModalRoute.of(context)?.settings.arguments as Map<String, String>;
    categoryId = routArg['id']!;

    /* هنا بقا بنحط ويير عشان نشوف احنا واقفين ف انهي نوع وجبات يعني هيشوف الاي دي بتاع الصفحه اللي ضغط عليها اللي فيها انواع الوجابات وتقارنه بالاسترينج (اي دي يعني) اللي موجود فالكاتيجوريز وتشوف لو الاي دي مضاف للكاتيجوريز ضيفه */
    displayesMeals = availableMeals.where((mealItem) {
      return mealItem.categories.contains(categoryId);
    }).toList();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    bool isLandScap =
        MediaQuery.of(context).orientation == Orientation.landscape;
    var dw = MediaQuery.of(context).size.width;
    var lan = Provider.of<LanguageProvider>(context, listen: true);
    return Directionality(
      textDirection: lan.isEn ? TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text(lan.getTexts('cat-$categoryId').toString()),
        ),
        body: GridView.builder(
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: dw <= 400 ? 400 : 500,
            crossAxisSpacing: 0,
            mainAxisSpacing: 0,
            childAspectRatio: isLandScap ? dw / (dw * 0.71) : dw / (dw * 0.715),
          ),
          itemBuilder: (ctx, index) {
            return MealItem(
              affordability: displayesMeals[index].affordability,
              complexity: displayesMeals[index].complexity,
              duration: displayesMeals[index].duration,
              imageUrl: displayesMeals[index].imageUrl,
              id: displayesMeals[index].id,
            );
          },
          itemCount: displayesMeals.length,
        ),
      ),
    );
  }
}
