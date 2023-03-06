// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:meal_app/provider/mealprovider.dart';
import 'package:meal_app/widgets/category_item.dart';

import '../provider/language_provider.dart';

/* هنا الاسكرين اللي بتظهر انواع الوجبات */
class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var lan = Provider.of<LanguageProvider>(context, listen: true);
    return Directionality(
      textDirection: lan.isEn ? TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
        body: GridView(
          padding: const EdgeInsets.all(10),
          // from availableCategory
          children: Provider.of<MealProvider>(context)
              .availableCategory
              .map((catData) => CategoryItem(
                  //ظهرنا الويدجت اللي عملناها  ف category item
                  id: catData.id,
                  color: catData.color))
              .toList(),
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
            childAspectRatio: 1.5,
          ),
        ),
      ),
    );
  }
}
