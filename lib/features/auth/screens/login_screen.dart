import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scube_task/core/theme/app_colors.dart';
import 'package:scube_task/features/auth/widgets/auth_widgets.dart';
import 'package:scube_task/features/dashboard/screens/dashboard_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscure = true;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState?.validate() ?? false) {
      Navigator.of(context)
          .pushReplacementNamed(DashboardScreen.routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final width = size.width;
    final height = size.height;
    final topHeight = height * 0.52;
    final curvedRadius = width * 0.08;

    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: topHeight,
              width: double.infinity,
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(curvedRadius * 1.4),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/logo.png',
                      width: width * 0.25,
                      height: width * 0.25,
                      fit: BoxFit.contain,
                    ),
                    SizedBox(height: height * 0.04),
                    Text(
                      'SCUBE',
                      style: GoogleFonts.manrope(
                        color: AppColors.white,
                        fontSize: width * 0.07,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.2,
                      ),
                    ),
                    SizedBox(height: height * 0.01),
                    Text(
                      'Control & Monitoring System',
                      style: GoogleFonts.manrope(
                        color: AppColors.white,
                        fontSize: width * 0.055,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(curvedRadius * 1.2),
                  ),
                ),
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(
                    horizontal: width * 0.07,
                    vertical: height * 0.035,
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Login',
                          style: GoogleFonts.manrope(
                            color: AppColors.textDark,
                            fontSize: width * 0.085,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        SizedBox(height: height * 0.04),
                        AuthTextField(
                          hint: 'Username',
                          controller: _usernameController,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Username is required';
                            }
                            return null;
                          },
                          textInputAction: TextInputAction.next,
                        ),
                        SizedBox(height: height * 0.022),
                        AuthTextField(
                          hint: 'Password',
                          obscureText: _obscure,
                          controller: _passwordController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Password is required';
                            }
                            if (value.length < 6) {
                              return 'Minimum 6 characters';
                            }
                            return null;
                          },
                          textInputAction: TextInputAction.done,
                          suffix: IconButton(
                            icon: Icon(
                              _obscure
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                              color: AppColors.textBody,
                            ),
                            onPressed: () =>
                                setState(() => _obscure = !_obscure),
                          ),
                        ),
                        SizedBox(height: height * 0.015),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding: EdgeInsets.only(right: width * 0.02),
                            child: Text(
                              'Forget password?',
                              style: GoogleFonts.manrope(
                                color: AppColors.textBody,
                                fontSize: width * 0.042,
                                decoration: TextDecoration.underline,
                                decorationColor: AppColors.textBody,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: height * 0.04),
                        PrimaryButton(label: 'Login', onPressed: _submit),
                        SizedBox(height: height * 0.03),
                        RichText(
                          text: TextSpan(
                            text: "Don't have any account? ",
                            style: GoogleFonts.manrope(
                              color: AppColors.textBody,
                              fontSize: width * 0.045,
                              fontWeight: FontWeight.w600,
                            ),
                            children: [
                              TextSpan(
                                text: 'Register Now',
                                style: GoogleFonts.manrope(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.w700,
                                  decoration: TextDecoration.underline,
                                  decorationColor: AppColors.primary,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: height * 0.02),
                      ],
                    ),
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
