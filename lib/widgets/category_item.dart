import 'package:flutter/material.dart';
import 'package:meal_app/screens/2_category_meals_screen.dart';
import 'package:provider/provider.dart';

import '../provider/language_provider.dart';

/* دا عباره عن ويدجت زرار لما اضغط عليه هينقلني لصفحه تانيه ويرسل البيانات */
class CategoryItem extends StatelessWidget {
  const CategoryItem({Key? key, required this.id, required this.color})
      : super(key: key);
  final String id;
  final Color color;
/* founction  push to category meal screan and send data*/
  void selectCategory(BuildContext ctx) {
    //هينقلني و هياخد الid و title
    Navigator.of(ctx).pushNamed(
      CategoryMealsScreen.routName,
      arguments: {
        'id': id,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var lan = Provider.of<LanguageProvider>(context, listen: true);
    return InkWell(
      onTap: () => selectCategory(context),
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              color,
              color.withOpacity(.5),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Text(
          lan.getTexts('cat-$id') as String,
          style: Theme.of(context).textTheme.headline6,
        ),
      ),
    );
  }
}
