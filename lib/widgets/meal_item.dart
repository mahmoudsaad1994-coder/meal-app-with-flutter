import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/meal.dart';
import '../provider/language_provider.dart';
import '../screens/3_meal_details_screen.dart';

class MealItem extends StatelessWidget {
  final String id;
  final Complexity complexity;
  final Affordability affordability;
  final String imageUrl;

  final int duration;

  const MealItem({
    Key? key,
    required this.complexity,
    required this.affordability,
    required this.imageUrl,
    required this.duration,
    required this.id,
  }) : super(key: key);

  void selectMeal(BuildContext ctx) {
    Navigator.of(ctx).pushNamed(
      MealDetailsScreen.routName,
      arguments: id,
    );
  }

  @override
  Widget build(BuildContext context) {
    var lan = Provider.of<LanguageProvider>(context, listen: true);
    return InkWell(
      onTap: () => selectMeal(context),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        elevation: 4,
        margin: const EdgeInsets.all(10),
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                    ),
                    child: Hero(
                      tag: id,
                      child: FadeInImage(
                        image: NetworkImage(
                          imageUrl,
                        ),
                        height: 200,
                        width: double.infinity,
                        placeholder: const AssetImage('assets/images/a2.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 20,
                    right: 10,
                    child: Container(
                      child: Text(
                        lan.getTexts('meal-$id') as String,
                        style:
                            const TextStyle(fontSize: 26, color: Colors.white),
                        softWrap: true,
                        overflow: TextOverflow.fade,
                      ),
                      color: Colors.black45,
                      width: 300,
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 20),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.schedule,
                              color: Theme.of(context).splashColor),
                          const SizedBox(
                            width: 6,
                          ),
                          Text('$duration ${lan.getTexts('min')}'),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(Icons.work,
                              color: Theme.of(context).splashColor),
                          const SizedBox(
                            width: 6,
                          ),
                          Text(lan.getTexts('$complexity') as String),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(Icons.attach_money,
                              color: Theme.of(context).splashColor),
                          const SizedBox(
                            width: 6,
                          ),
                          Text(lan.getTexts('$affordability') as String),
                        ],
                      ),
                    ]),
              ),
            )
          ],
        ),
      ),
    );
  }
}
