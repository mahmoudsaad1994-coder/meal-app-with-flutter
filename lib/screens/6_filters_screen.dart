// ignore_for_file: use_key_in_widget_constructors, file_names

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:meal_app/provider/theme_provider.dart';
import 'package:meal_app/widgets/main_drawer.dart';

import '../provider/language_provider.dart';
import '../provider/mealprovider.dart';

class FiltersScreen extends StatefulWidget {
  static const routName = '/filters';
  final bool fromOnBoarding;

  const FiltersScreen({Key? key, this.fromOnBoarding = false})
      : super(key: key);
  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  SwitchListTile buildSwitchListTile(String title, String description,
      bool value, Function(bool) updateValue) {
    return SwitchListTile(
      title: Text(title),
      value: value,
      onChanged: updateValue,
      subtitle: Text(description),
      inactiveTrackColor:
          Provider.of<ThemeProvider>(context).themeMode == ThemeMode.light
              ? null
              : Colors.black,
    );
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, bool> currentFilters =
        Provider.of<MealProvider>(context, listen: false).filters;
    var lan = Provider.of<LanguageProvider>(context, listen: true);
    return Directionality(
      textDirection: lan.isEn ? TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
        appBar: widget.fromOnBoarding
            ? AppBar(
                backgroundColor: Theme.of(context).canvasColor,
                elevation: 0,
              )
            : AppBar(
                title: Text(lan.getTexts('filters_appBar_title').toString()),
                centerTitle: true,
              ),
        body: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              child: Text(
                lan.getTexts('theme_screen_title').toString(),
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            Expanded(
                child: ListView(
              children: [
                buildSwitchListTile(
                    lan.getTexts('Gluten-free').toString(),
                    lan.getTexts('Gluten-free-sub').toString(),
                    currentFilters['gluten']!, (newValue) {
                  setState(() {
                    currentFilters['gluten'] = newValue;
                  });
                  Provider.of<MealProvider>(context, listen: false)
                      .setFilters();
                }),
                buildSwitchListTile(
                    lan.getTexts('Lactose-free').toString(),
                    lan.getTexts('Lactose-free_sub').toString(),
                    currentFilters['lactose']!, (newValue) {
                  setState(() {
                    currentFilters['lactose'] = newValue;
                  });
                  Provider.of<MealProvider>(context, listen: false)
                      .setFilters();
                }),
                buildSwitchListTile(
                    lan.getTexts('Vegan').toString(),
                    lan.getTexts('Vegan-sub').toString(),
                    currentFilters['vegan']!, (newValue) {
                  setState(() {
                    currentFilters['vegan'] = newValue;
                  });
                  Provider.of<MealProvider>(context, listen: false)
                      .setFilters();
                }),
                buildSwitchListTile(
                    lan.getTexts('Vegetarian').toString(),
                    lan.getTexts('Vegetarian-sub').toString(),
                    currentFilters['vegatarian']!, (newValue) {
                  setState(() {
                    currentFilters['vegatarian'] = newValue;
                  });
                  Provider.of<MealProvider>(context, listen: false)
                      .setFilters();
                }),
                SizedBox(
                  height: widget.fromOnBoarding ? 85 : 0,
                )
              ],
            ))
          ],
        ),
        drawer: widget.fromOnBoarding ? null : const MainDrawer(),
      ),
    );
  }
}
