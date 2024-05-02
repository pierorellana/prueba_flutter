import 'package:flutter/material.dart';
import '../../../env/theme/app_theme.dart';
import '../filled_button.dart';

class CardWidget extends StatelessWidget {
  final String userName;
  final String userLastName;
  final String userEmail;
  final VoidCallback onDelete;

  const CardWidget({
    Key? key,
    required this.userName,
    required this.userLastName,
    required this.userEmail,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Card(
      surfaceTintColor: AppTheme.white,
      color: AppTheme.white,
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: size.height * 0.01),
            Text(
              userName,
              style: const TextStyle(
                color: AppTheme.primaryColor,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            SizedBox(height: size.height * 0.015),
            Text(
              userLastName,
              style: const TextStyle(
                color: AppTheme.primaryColor,
                fontSize: 13,
                fontWeight: FontWeight.bold,
              ),
              maxLines: 18,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: size.height * 0.015),
            Text(
              userEmail,
              style: const TextStyle(
                color: AppTheme.hinText,
                fontSize: 13,
                fontWeight: FontWeight.bold,
              ),
              maxLines: 18,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: size.height * 0.015),
            Row(
              children: [
                Expanded(
                  child: FilledButtonWidget(
                    color: AppTheme.secondaryColor,
                    textButtonColor: AppTheme.white,
                    text: 'Editar Usuario',
                    onPressed: () {},
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: FilledButtonWidget(
                    color: AppTheme.secondaryColor,
                    textButtonColor: AppTheme.white,
                    text: 'Eliminar Usuario',
                    onPressed: onDelete,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
