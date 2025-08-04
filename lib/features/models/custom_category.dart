import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'custom_category.g.dart';

@HiveType(typeId: 1)
class CustomCategory extends HiveObject {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final int iconCodePoint;

  @HiveField(2)
  final String iconFontFamily; // Now required

  @HiveField(3)
  final String type;

  CustomCategory({
    required this.name,
    required this.iconCodePoint,
    required this.iconFontFamily,
    required this.type,
  });

  IconData get icon => IconData(iconCodePoint, fontFamily: iconFontFamily);
}
