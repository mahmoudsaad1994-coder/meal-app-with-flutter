// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:meal_app/dummy_data.dart';
import 'package:meal_app/provider/theme_provider.dart';

import '../provider/language_provider.dart';
import '../provider/mealprovider.dart';

class MealDetailsScreen extends StatefulWidget {
  static const routName = 'meal_detail';

  const MealDetailsScreen({Key? key}) : super(key: key);

  @override
  State<MealDetailsScreen> createState() => _MealDetailsScreenState();
}

class _MealDetailsScreenState extends State<MealDetailsScreen> {
  String mealId = '';
  @override
  void didChangeDependencies() {
    mealId = ModalRoute.of(context)!.settings.arguments as String;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    var lan = Provider.of<LanguageProvider>(context, listen: true);
    bool isLandScap =
        MediaQuery.of(context).orientation == Orientation.landscape;

    final selectedMeal = DUMMY_MEALS.firstWhere(
      (meal) => meal.id == mealId,
    );
    var accentColor = Theme.of(context).colorScheme.secondary;
    List<String> ingredientsList =
        lan.getTexts('ingredients-$mealId') as List<String>;
    List<String> stepsList = lan.getTexts('steps-$mealId') as List<String>;

    var buildSteps = ListView.builder(
      padding: const EdgeInsets.all(0),
      itemBuilder: (ctx, index) => Column(
        children: [
          ListTile(
            leading: CircleAvatar(
              child: Text(lan.isEn ? '#${index + 1}' : '${index + 1}#'),
              backgroundColor: Theme.of(context).colorScheme.primary,
              foregroundColor: Colors.white,
            ),
            title: Text(
              stepsList[index],
              style: const TextStyle(
                color: Colors.black,
              ),
            ),
          ),
          const Divider()
        ],
      ),
      itemCount: stepsList.length,
    );
    var buildIngredient = ListView.builder(
      padding: const EdgeInsets.all(0),
      itemBuilder: (ctx, index) => Card(
        color: accentColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          child: Text(
            ingredientsList[index],
            style: TextStyle(
              color: Provider.of<ThemeProvider>(context).themeMode ==
                      ThemeMode.dark
                  ? Colors.white
                  : Colors.black,
            ),
          ),
        ),
      ),
      itemCount: ingredientsList.length,
    );

    return Directionality(
      textDirection: lan.isEn ? TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 300,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                title: Text(lan.getTexts('meal-$mealId').toString()),
                background: Hero(
                  tag: mealId,
                  child: InteractiveViewer(
                    child: FadeInImage(
                      image: NetworkImage(
                        selectedMeal.imageUrl,
                      ),
                      placeholder: const AssetImage('assets/images/a2.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate([
                if (isLandScap)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          buildTitle(
                              lan.getTexts('Ingredients').toString(), context),
                          buildContainer(buildIngredient, 20),
                        ],
                      ),
                      Column(
                        children: [
                          buildTitle(lan.getTexts('Steps').toString(), context),
                          buildContainer(buildSteps, 20)
                        ],
                      ),
                    ],
                  ),
                if (!isLandScap)
                  buildTitle(lan.getTexts('Ingredients').toString(), context),
                if (!isLandScap) buildContainer(buildIngredient, 0),
                if (!isLandScap)
                  buildTitle(lan.getTexts('Steps') as String, context),
                if (!isLandScap) buildContainer(buildSteps, 20),
              ]),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => Provider.of<MealProvider>(context, listen: false)
              .toggleFavorite(mealId),
          child: Icon(Provider.of<MealProvider>(context, listen: true)
                  .isMealFavorite(mealId)
              ? Icons.star
              : Icons.star_border),
        ),
      ),
    );
  }

  Container buildContainer(Widget child, double marginBottom) {
    bool isLandScap =
        MediaQuery.of(context).orientation == Orientation.landscape;
    var dw = MediaQuery.of(context).size.width;
    var dh = MediaQuery.of(context).size.height;
    return Container(
        margin: EdgeInsets.only(bottom: marginBottom, right: 10, left: 10),
        width: isLandScap ? (dw * 0.5 - 30) : dw,
        height: isLandScap ? dh * 0.5 : dh * 0.25,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(15),
        ),
        child: child);
  }

  Container buildTitle(String textTitle, BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Text(
        textTitle,
        style: Theme.of(context).textTheme.titleMedium,
        textAlign: TextAlign.center,
      ),
    );
  }
}
