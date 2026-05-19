import 'package:epicare_flutter/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class EpiCareLogo extends StatelessWidget {
  const EpiCareLogo({
    super.key,
    this.width = 220,
    this.textSize = 34,
  });

  final double width;
  final double textSize;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            child: Text(
              'EpiCare',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: AppColors.primary,
                fontSize: textSize,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w900,
                height: 1,
              ),
            ),
          ),
          const SizedBox(width: 6),
          const Icon(Icons.monitor_heart_rounded, color: AppColors.primary, size: 38),
        ],
      ),
    );
  }
}
