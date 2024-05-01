import 'package:flutter/material.dart';

import '../../env/theme/app_theme.dart';

Widget placeHolderWidget({
  required String placeholder,
  Color? color, 
  FontWeight? fontWeight = FontWeight.bold,
  double? fontSize = 15.5,
}) {
  return Align(
    alignment: Alignment.centerLeft,
    child: Text(
      placeholder,
      overflow: TextOverflow.ellipsis,
      maxLines: 1,
      style: TextStyle(
        color: color ?? AppTheme.primaryColor, 
        fontWeight: fontWeight,
        fontSize: fontSize,
      ),
    ),
  );
}
