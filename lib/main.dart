import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scube_task/features/auth/screens/login_screen.dart';
import 'package:scube_task/features/dashboard/screens/dashboard_screen.dart';
import 'core/theme/app_colors.dart';


void main() {
  runApp(const ScubeTaskApp());
}

class ScubeTaskApp extends StatelessWidget {
  const ScubeTaskApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Scube Task',
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.background,
        textTheme: GoogleFonts.manropeTextTheme(),
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
        useMaterial3: true,
      ),
      home: const LoginScreen(),
      routes: {
        DashboardScreen.routeName: (_) => const DashboardScreen(),
      },
    );
  }
}
