import 'package:flutter/material.dart';
import 'config/app_routes.dart';
import 'config/app_theme.dart';
import 'features/auth/presentation/login_view.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SIAKAD FTUMT',
      theme: AppTheme.lightTheme,
      initialRoute: AppRoutes.login,
      routes: AppRoutes.routes,
      debugShowCheckedModeBanner: false,
    );
  }
}
