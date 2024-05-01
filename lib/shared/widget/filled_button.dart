import 'package:flutter/material.dart';

import '../../env/theme/app_theme.dart';

class FilledButtonWidget extends StatefulWidget {
  const FilledButtonWidget({
    super.key,
    this.onPressed,
    this.color,
    required this.text,
    this.width = double.infinity,
    this.height = 40,
    this.borderRadius = 15,
    this.textButtonColor,
  });

  final void Function()? onPressed;
  final Color? color;
  final String text;
  final double? width;
  final double? height;
  final double? borderRadius;
  final Color? textButtonColor;

  @override
  State<FilledButtonWidget> createState() => _FilledButtonWidgetState();
}

class _FilledButtonWidgetState extends State<FilledButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return FilledButton(
      style: ButtonStyle(
        minimumSize: MaterialStateProperty.all<Size>(
            Size(widget.width!, widget.height!)),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(widget.borderRadius!)),
        ),
        backgroundColor:
            MaterialStatePropertyAll(widget.color ?? AppTheme.primaryColor),
      ),
      onPressed: widget.onPressed,
      child: Text(widget.text,
          style: TextStyle(
              color: widget.textButtonColor ?? AppTheme.primaryColor,
              fontWeight: FontWeight.w600,
              fontSize: 15),
          textAlign: TextAlign.center),
    );
  }
}
