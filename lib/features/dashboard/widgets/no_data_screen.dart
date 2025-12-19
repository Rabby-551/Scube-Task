import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scube_task/core/theme/app_colors.dart';

class NoDataScreen extends StatelessWidget {
  const NoDataScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final width = size.width;
    final bgColor = const Color(0xFFE5EDF6);
    final borderColor = const Color(0xFFB8C9DC);

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: width * 0.04,
                vertical: width * 0.025,
              ),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.of(context).maybePop(),
                    icon: Icon(
                      Icons.arrow_back,
                      color: const Color(0xFF1E2556),
                      size: width * 0.08,
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        'SCM',
                        style: GoogleFonts.manrope(
                          color: const Color(0xFF0D1140),
                          fontSize: width * 0.065,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ),
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.notifications_none_outlined,
                          color: const Color(0xFF1E2556),
                          size: width * 0.08,
                        ),
                      ),
                      Positioned(
                        right: width * 0.022,
                        top: width * 0.028,
                        child: Container(
                          width: width * 0.035,
                          height: width * 0.035,
                          decoration: BoxDecoration(
                            color: const Color(0xFFE03232),
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 2),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                child: Container(
                  height: size.height * 0.4,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(width * 0.06),
                    border: Border.all(color: borderColor, width: 1.2),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: size.width * 0.9,
                        height: width * 0.5,
                        child: Image.asset(
                          'assets/images/no_data.png',
      
                          fit: BoxFit.contain,
                        ),
                      ),
                      SizedBox(height: 10,),
                      Text(
                        'No data is here,\nplease wait.',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.manrope(
                          color: AppColors.textBody,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          height: 1.3,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
