import 'package:flutter/material.dart';
import 'src/config/app_routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Siakad Apps',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: AppRoutes.login, // ganti ke AppRoutes.dashboard kalau mau langsung dashboard
      routes: AppRoutes.routes,
    );
  }
}
