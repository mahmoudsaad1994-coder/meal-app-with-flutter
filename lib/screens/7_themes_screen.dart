// ignore_for_file: use_key_in_widget_constructors, file_names

import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:provider/provider.dart';

import 'package:meal_app/provider/theme_provider.dart';
import 'package:meal_app/widgets/main_drawer.dart';

import '../provider/language_provider.dart';

class ThemesScreen extends StatelessWidget {
  static const routName = '/themes';
  final bool fromOnBoarding;

  const ThemesScreen({Key? key, this.fromOnBoarding = false}) : super(key: key);
  RadioListTile buildRadioListTileThemeMode(
      {required String title,
      required BuildContext ctx,
      required ThemeMode themeVal,
      IconData? icon}) {
    return RadioListTile(
      title: Text(title),
      value: themeVal,
      secondary: icon == null
          ? null
          : Icon(
              icon,
              color: Theme.of(ctx).splashColor,
            ),
      groupValue: Provider.of<ThemeProvider>(ctx, listen: true).themeMode,
      onChanged: (newThemeVal) => Provider.of<ThemeProvider>(ctx, listen: false)
          .themeModeChange(newThemeVal),
    );
  }

  RadioListTile buildRadioListTileLanguage({
    required String title,
    required BuildContext ctx,
    required bool lanVal,
  }) {
    return RadioListTile(
      title: Text(title),
      value: lanVal,
      groupValue: Provider.of<LanguageProvider>(ctx, listen: true).isEn,
      onChanged: (newLanVal) =>
          Provider.of<LanguageProvider>(ctx, listen: false)
              .changeLan(newLanVal),
    );
  }

  @override
  Widget build(BuildContext context) {
    var lan = Provider.of<LanguageProvider>(context, listen: true);
    return Directionality(
      textDirection: lan.isEn ? TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
        appBar: fromOnBoarding
            ? AppBar(
                backgroundColor: Theme.of(context).canvasColor,
                elevation: 0,
              )
            : AppBar(
                title: Text(lan.getTexts('theme_appBar_title').toString()),
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
                Container(
                  padding: const EdgeInsets.all(20),
                  child: Text(
                    lan.getTexts('theme_mode_title').toString(),
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
                buildRadioListTileThemeMode(
                  title: lan.getTexts('System_default_theme').toString(),
                  ctx: context,
                  themeVal: ThemeMode.system,
                ),
                buildRadioListTileThemeMode(
                    title: lan.getTexts('light_theme').toString(),
                    ctx: context,
                    themeVal: ThemeMode.light,
                    icon: Icons.wb_sunny_outlined),
                buildRadioListTileThemeMode(
                    title: lan.getTexts('dark_theme').toString(),
                    ctx: context,
                    themeVal: ThemeMode.dark,
                    icon: Icons.nights_stay_outlined),
                buildListTile(context, lan.getTexts('primary').toString()),
                buildListTile(context, lan.getTexts('accent').toString()),
                Container(
                  alignment:
                      lan.isEn ? Alignment.centerLeft : Alignment.centerRight,
                  padding: const EdgeInsets.only(right: 20, left: 20),
                  child: Text(
                    lan.getTexts('drawer_switch_title').toString(),
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
                buildRadioListTileLanguage(
                  ctx: context,
                  lanVal: false,
                  title: lan.getTexts('drawer_switch_item2').toString(),
                ),
                buildRadioListTileLanguage(
                  ctx: context,
                  lanVal: true,
                  title: lan.getTexts('drawer_switch_item1').toString(),
                ),
                SizedBox(
                  height: fromOnBoarding ? 85 : 0,
                )
              ],
            )),
          ],
        ),
        drawer: fromOnBoarding ? null : const MainDrawer(),
      ),
    );
  }

  ListTile buildListTile(BuildContext ctx, String txt) {
    var primaryColor =
        Provider.of<ThemeProvider>(ctx, listen: true).primaryColor;
    var accentColor = Provider.of<ThemeProvider>(ctx, listen: true).accentColor;
    return ListTile(
      title: Text(
        txt,
        style: Theme.of(ctx).textTheme.headline6,
      ),
      trailing: CircleAvatar(
        backgroundColor:
            txt == 'Choose your primary color' ? primaryColor : accentColor,
      ),
      onTap: () {
        showDialog(
            context: ctx,
            builder: (BuildContext contxt) {
              return AlertDialog(
                elevation: 4,
                titlePadding: const EdgeInsets.all(0),
                contentPadding: const EdgeInsets.all(0),
                content: SingleChildScrollView(
                  child: ColorPicker(
                    pickerColor: txt == 'Choose your primary color'
                        ? Provider.of<ThemeProvider>(ctx, listen: true)
                            .primaryColor
                        : Provider.of<ThemeProvider>(ctx, listen: true)
                            .accentColor,
                    onColorChanged: (newColor) {
                      Provider.of<ThemeProvider>(ctx, listen: false).onChange(
                          newColor, txt == 'Choose your primary color' ? 1 : 2);
                    },
                    colorPickerWidth: 300,
                    pickerAreaHeightPercent: 0.7,
                    enableAlpha: false,
                    displayThumbColor: true,
                    labelTypes: const [],
                  ),
                ),
              );
            });
      },
    );
  }
}
