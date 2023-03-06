import 'package:flutter/material.dart';
import 'package:meal_app/provider/language_provider.dart';
import 'package:meal_app/screens/4_tabs_screen.dart';
import 'package:meal_app/screens/6_filters_screen.dart';
import 'package:meal_app/screens/7_themes_screen.dart';
import 'package:provider/provider.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({Key? key}) : super(key: key);

  ListTile buildListTile(
      String title, IconData icon, Function() tapHunder, BuildContext ctx) {
    return ListTile(
      leading: Icon(
        icon,
        size: 26,
        color: Theme.of(ctx).splashColor,
      ),
      title: Text(
        title,
        style: TextStyle(
          color: Theme.of(ctx).textTheme.bodyText1!.color,
          fontSize: 24,
          fontFamily: 'RobotoCondensed',
          fontWeight: FontWeight.bold,
        ),
      ),
      onTap: tapHunder,
    );
  }

  @override
  Widget build(BuildContext context) {
    var lan = Provider.of<LanguageProvider>(context, listen: true);
    return Directionality(
      textDirection: lan.isEn ? TextDirection.ltr : TextDirection.rtl,
      child: Drawer(
        elevation: 0,
        child: Column(
          children: [
            Stack(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 180,
                  child: Image.asset(
                    'assets/images/bac.jpg',
                    fit: BoxFit.fill,
                  ),
                ),
                Positioned(
                  bottom: 10,
                  left: 0,
                  right:0,
                  child: Container(
                      color: Theme.of(context)
                          .colorScheme
                          .secondary
                          .withOpacity(0.6),
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 10),
                      child: Text(
                        lan.getTexts('drawer_name') as String,textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w900,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      )),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            const SizedBox(
              height: 20,
            ),
            buildListTile(
                lan.getTexts('drawer_item1') as String, Icons.restaurant, () {
              Navigator.of(context).pushReplacementNamed(TabsScreen.routName);
            }, context),
            buildListTile(
                lan.getTexts('drawer_item2') as String, Icons.settings, () {
              Navigator.of(context)
                  .pushReplacementNamed(FiltersScreen.routName);
            }, context),
            buildListTile(
                lan.getTexts('drawer_item3') as String, Icons.color_lens, () {
              Navigator.of(context).pushReplacementNamed(ThemesScreen.routName);
            }, context),
          ],
        ),
      ),
    );
  }
}
