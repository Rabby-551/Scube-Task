import 'package:flutter/material.dart';
import 'package:scube_task/core/theme/app_colors.dart';

class DashboardDataCard extends StatelessWidget {
  const DashboardDataCard({
    super.key,
    required this.title,
    required this.statusLabel,
    required this.statusColor,
    required this.assetPath,
    required this.accentColor,
    required this.data1,
    required this.data2,
    this.onTap,
  });

  final String title;
  final String statusLabel;
  final Color statusColor;
  final String assetPath;
  final Color accentColor;
  final String data1;
  final String data2;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final padding = width * 0.035;
    final iconSize = width * 0.12;
    const cornerRadius = 14.0;
    const dataColor = Color(0xFF6E7B8A);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(cornerRadius),
        onTap: onTap,
        child: Container(
          constraints: const BoxConstraints(minHeight: 110),
          padding: EdgeInsets.all(padding),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFFFDFEFF),
                Color(0xFFB8C9DC),
              ],
            ),
            borderRadius: BorderRadius.circular(cornerRadius),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.06),
                blurRadius: 6,
                offset: const Offset(0, 3),
              ),
            ],
            border: Border.all(
              color: const Color(0xFFC9D6E6),
              width: 1,
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    padding: EdgeInsets.all(width * 0.018),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: accentColor.withValues(alpha: 0.4),
                      ),
                    ),
                    child: Image.asset(
                      assetPath,
                      width: iconSize,
                      height: iconSize,
                      fit: BoxFit.contain,
                    ),
                  ),
                ],
              ),
              SizedBox(width: width * 0.035),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: width * 0.032,
                          height: width * 0.032,
                          decoration: BoxDecoration(
                            color: accentColor,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        SizedBox(width: width * 0.018),
                        Flexible(
                          child: Text(
                            title,
                            style: TextStyle(
                              color: AppColors.textDark,
                              fontSize: 14,
                              fontWeight: FontWeight.w800,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        SizedBox(width: width * 0.015),
                        Flexible(
                          child: Text(
                            '($statusLabel)',
                            style: TextStyle(
                              color: statusColor,
                              fontSize: width * 0.04,
                              fontWeight: FontWeight.w600,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: width * 0.018),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Data 1   :  $data1',
                            style: TextStyle(
                              color: dataColor,
                              fontSize: width * 0.041,
                              fontWeight: FontWeight.w600,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: width * 0.012),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Data 2   :  $data2',
                            style: TextStyle(
                              color: dataColor,
                              fontSize: width * 0.041,
                              fontWeight: FontWeight.w600,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.chevron_right,
                color: AppColors.textBody.withValues(alpha: 0.7),
                size: width * 0.08,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
