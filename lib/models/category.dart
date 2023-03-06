import 'package:flutter/material.dart';

/* كلاس لاضافه انواع الاكلات */
class Category {
  final String id;
  final Color color;

  Category({
    required this.id,
    this.color = Colors.orange,
  });
}
