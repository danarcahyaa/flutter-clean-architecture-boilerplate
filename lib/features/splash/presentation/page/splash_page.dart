import 'package:flutter/material.dart';
import '../../../../core/routes/route_names.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/themes/app_colors.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _navigateToNext();
  }

  /// Handles the initial logic before moving to the next screen.
  Future<void> _navigateToNext() async {
    // Simulate a delay for branding or wait for DI/Services to be ready
    await Future.delayed(const Duration(seconds: 1));

    if (!mounted) return;

    // TODO: Add logic to check Auth Status
    // Example: If (userLoggedIn) -> RouteNames.home else -> RouteNames.login

    context.go(RouteNames.home);
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.primary,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Replace with your App Logo
            Icon(
              Icons.app_registration,
              size: 100,
              color: Colors.white,
            ),
            SizedBox(height: 24),
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}