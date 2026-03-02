import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../Theme/app_theme.dart';
import '../models/hobby_data.dart';

class TrophyDialog extends StatelessWidget {
  final Hobby hobby;

  const TrophyDialog({
    super.key,
    required this.hobby,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: AppStyles.radiusLarge),
      backgroundColor: AppColors.backgroundPastel,
      title: Text(
        'Trophäe freigeschaltet!',
        textAlign: TextAlign.center,
        style: AppTypography.headlineMedium,
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            hobby.svgPath,
            width: 120,
            height: 120,
          ),
          const SizedBox(height: 20),
          Text(
            'Du hast "${hobby.title}" gemeistert.\nSuper gemacht!',
            textAlign: TextAlign.center,
            style: AppTypography.body,
          ),
        ],
      ),
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primaryAccent,
            shape: RoundedRectangleBorder(borderRadius: AppStyles.radiusSmall),
          ),
          onPressed: () {
            Navigator.of(context).pop(); //schließt pop-up
          },
          child: Text('Juhu!', style: AppTypography.textWhiteBold),
        ),
      ],
    );
  }
}