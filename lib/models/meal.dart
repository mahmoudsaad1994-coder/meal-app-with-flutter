// ignore_for_file: constant_identifier_names

/* بنسخدمه عشان الاكله دي من نوع ايه بسيطه تقيله تحدي */
enum Complexity { Simple, Challenging, Hard }
/*  */
enum Affordability { Affordable, Pricey, Luxurious }

/* هنا بنعمل كلاس للاكل نفسه */
class Meal {
  final String id;
  final String imageUrl;
  final List<String> categories;

  final Complexity complexity;
  final Affordability affordability;
  final bool isGlutenFree;
  final bool isLactoseFree;
  final bool isVegan;
  final bool isVegetarian;
  final int duration;

  Meal({
    required this.id,
    required this.imageUrl,
    required this.categories,
    required this.duration,
    required this.complexity,
    required this.affordability,
    required this.isGlutenFree,
    required this.isLactoseFree,
    required this.isVegan,
    required this.isVegetarian,
  });
}
