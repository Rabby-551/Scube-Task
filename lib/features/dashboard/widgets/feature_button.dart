import 'package:flutter/material.dart';
import 'package:scube_task/core/theme/app_colors.dart';

class FeatureButton extends StatelessWidget {
  const FeatureButton({
    super.key,
    required this.label,
    required this.assetPath,
    this.onTap,
  });

  final String label;
  final String assetPath;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final cornerRadius = 14.0;

    return Material(
      color: Colors.white,
      elevation: 0,
      borderRadius: BorderRadius.circular(cornerRadius),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(cornerRadius),
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: width * 0.02,
            vertical: width * 0.03,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(cornerRadius),
            border: Border.all(color: const Color(0xFFD6DFEA)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.03),
                blurRadius: 6,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            children: [
              Image.asset(
                assetPath,
                width: width * 0.10,
                height: width * 0.10,
                fit: BoxFit.contain,
              ),
              SizedBox(width: width * 0.04),
              Expanded(
                child: Text(
                  label,
                  style: TextStyle(
                    color: AppColors.textDark,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.visible,
                ),
              ),
    
            ],
          ),
        ),
      ),
    );
  }
}
