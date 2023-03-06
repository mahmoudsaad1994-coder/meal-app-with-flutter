import 'package:flutter/material.dart';
import 'package:meal_app/screens/on_boarding_screen.dart';
import 'package:provider/provider.dart';

import 'package:meal_app/provider/theme_provider.dart';
import 'package:meal_app/screens/7_themes_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'provider/language_provider.dart';
import 'provider/mealprovider.dart';
import 'screens/2_category_meals_screen.dart';
import 'screens/3_meal_details_screen.dart';
import 'screens/4_tabs_screen.dart';
import 'screens/6_filters_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();

  Widget mainScreen = prefs.getBool('watched') ?? false
      ? const TabsScreen()
      : const OnBoardingScreen();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<MealProvider>(
          create: (ctx) => MealProvider(),
        ),
        ChangeNotifierProvider<ThemeProvider>(
          create: (ctx) => ThemeProvider(),
        ),
        ChangeNotifierProvider<LanguageProvider>(
          create: (ctx) => LanguageProvider(),
        ),
      ],
      child: MyApp(mainScreen: mainScreen),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, this.mainScreen}) : super(key: key);
  final Widget? mainScreen;
  @override
  Widget build(BuildContext context) {
    var primaryColor = Provider.of<ThemeProvider>(context).primaryColor;
    var accentColor = Provider.of<ThemeProvider>(context).accentColor;
    var themeMode = Provider.of<ThemeProvider>(context).themeMode;

    return MaterialApp(
      title: 'Flutter Meal App',
      themeMode: themeMode,
      theme: ThemeData(
        canvasColor: const Color.fromRGBO(255, 254, 229, 1),
        fontFamily: 'Raleway',
        splashColor: Colors.black87,
        shadowColor: Colors.white60,
        cardColor: Colors.white,
        textTheme: ThemeData.light().textTheme.copyWith(
              bodyText1: const TextStyle(
                color: Color.fromRGBO(20, 50, 50, 1),
              ),
              headline6: const TextStyle(
                  color: Colors.black87,
                  fontSize: 20,
                  fontFamily: 'RobotoCondensed',
                  fontWeight: FontWeight.bold),
            ),
        colorScheme: ColorScheme.fromSwatch(primarySwatch: primaryColor)
            .copyWith(secondary: accentColor),
      ),
      darkTheme: ThemeData(
        canvasColor: const Color.fromRGBO(14, 22, 33, 1),
        fontFamily: 'Raleway',
        splashColor: Colors.white60,
        shadowColor: Colors.white60,
        cardColor: const Color.fromRGBO(14, 22, 33, 1),
        unselectedWidgetColor: Colors.white70,
        textTheme: ThemeData.dark().textTheme.copyWith(
              bodyText1: const TextStyle(
                color: Colors.white60,
              ),
              headline6: const TextStyle(
                  color: Colors.white70,
                  fontSize: 20,
                  fontFamily: 'RobotoCondensed',
                  fontWeight: FontWeight.bold),
            ),
        colorScheme: ColorScheme.fromSwatch(primarySwatch: primaryColor)
            .copyWith(secondary: accentColor),
      ),
      // home: const CategoriesScreen(),

      routes: {
        '/': (context) => mainScreen!,
        TabsScreen.routName: (context) => const TabsScreen(),
        CategoryMealsScreen.routName: (context) => const CategoryMealsScreen(),
        MealDetailsScreen.routName: (context) => const MealDetailsScreen(),
        FiltersScreen.routName: (context) => const FiltersScreen(),
        ThemesScreen.routName: (context) => const ThemesScreen(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
