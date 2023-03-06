import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:meal_app/screens/4_tabs_screen.dart';
import 'package:meal_app/screens/7_themes_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

import '../provider/language_provider.dart';
import '6_filters_screen.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    var primaryColor = Theme.of(context).primaryColor;
    var lan = Provider.of<LanguageProvider>(context, listen: true);
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            children: [
              Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: ExactAssetImage("assets/images/image.jpg"),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      width: 300,
                      color: Theme.of(context).shadowColor,
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 20),
                      child: Text(
                        lan.getTexts("drawer_name").toString(),
                        style: Theme.of(context).textTheme.headline4!.copyWith(
                              color: useWhiteForeground(primaryColor)
                                  ? Colors.white
                                  : Colors.black,
                            ),
                        softWrap: true,
                        overflow: TextOverflow.fade,
                      ),
                    ),
                    Container(
                      width: 350,
                      color: Theme.of(context).shadowColor,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      margin: const EdgeInsets.only(bottom: 20),
                      child: Text(
                        lan.getTexts('app_description').toString(),
                        style: Theme.of(context).textTheme.headline4!.copyWith(
                              fontSize: 17,
                              color: useWhiteForeground(primaryColor)
                                  ? Colors.white
                                  : Colors.black,
                            ),
                        textDirection:
                            lan.isEn ? TextDirection.ltr : TextDirection.rtl,
                        softWrap: true,
                        overflow: TextOverflow.fade,
                      ),
                    ),
                  ],
                ),
              ),
              const ThemesScreen(fromOnBoarding: true),
              const FiltersScreen(fromOnBoarding: true),
            ],
            onPageChanged: (val) {
              setState(() {
                _currentIndex = val;
              });
            },
          ),
          Indicator(index: _currentIndex),
          Builder(
            builder: (ctx) => Align(
              alignment: const Alignment(0, 0.85),
              child: Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child: ElevatedButton(
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all(
                      lan.isEn
                          ? const EdgeInsets.all(7)
                          : const EdgeInsets.all(0),
                    ),
                    backgroundColor: MaterialStateProperty.all(primaryColor),
                  ),
                  child: Text(lan.getTexts('start').toString(),
                      style: TextStyle(
                          color: useWhiteForeground(primaryColor)
                              ? Colors.white
                              : Colors.black,
                          fontSize: 25)),
                  onPressed: () async {
                    Navigator.of(ctx).pushReplacementNamed(TabsScreen.routName);

                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    prefs.setBool('watched', true);
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Indicator extends StatelessWidget {
  final int index;

  const Indicator({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          buildContainer(context, 0),
          buildContainer(context, 1),
          buildContainer(context, 2),
        ],
      ),
    );
  }

  Widget buildContainer(BuildContext ctx, int i) {
    return index == i
        ? Icon(Icons.star, color: Theme.of(ctx).primaryColor)
        : Container(
            margin: const EdgeInsets.all(4),
            height: 15,
            width: 15,
            decoration: BoxDecoration(
              color: Theme.of(ctx).colorScheme.secondary,
              shape: BoxShape.circle,
            ),
          );
  }
}
