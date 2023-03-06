// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:meal_app/screens/1_categories_screen.dart';
import 'package:meal_app/screens/5_favorites.dart';
import 'package:meal_app/widgets/main_drawer.dart';

import '../provider/language_provider.dart';
import '../provider/mealprovider.dart';
import '../provider/theme_provider.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({Key? key}) : super(key: key);
  static const routName = 'tab_screen';
  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  List<Map<String, Object>> _pages = [];
  int _selectedPageIndex = 0;
  @override
  void initState() {
    //to get SharedPreferences data from provider
    Provider.of<MealProvider>(context, listen: false).getData();
    Provider.of<ThemeProvider>(context, listen: false).getThemeMode();
    Provider.of<ThemeProvider>(context, listen: false).getColorMode();
    Provider.of<LanguageProvider>(context, listen: false).getLanguage();

    _pages = [
      {'page': const CategoriesScreen(), 'title': 'categories'},
      {'page': FavoritesScreen(), 'title': 'your_favorites'}
    ];
    super.initState();
  }

  void _selectPage(int value) {
    setState(() {
      _selectedPageIndex = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    var lan = Provider.of<LanguageProvider>(context, listen: true);
    return Directionality(
      textDirection: lan.isEn ? TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
            title: Text(lan
                .getTexts('${_pages[_selectedPageIndex]["title"]}')
                .toString())),
        body: _pages[_selectedPageIndex]['page'] as Widget,
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          currentIndex: _selectedPageIndex,
          selectedItemColor: Theme.of(context).colorScheme.secondary,
          unselectedItemColor: Colors.white,
          onTap: _selectPage,
          items: [
            BottomNavigationBarItem(
                icon: const Icon(Icons.category),
                label: lan.getTexts('categories').toString()),
            BottomNavigationBarItem(
                icon: const Icon(Icons.star),
                label: lan.getTexts('favorites').toString()),
          ],
        ),
        drawer: const MainDrawer(),
      ),
    );
  }
}
