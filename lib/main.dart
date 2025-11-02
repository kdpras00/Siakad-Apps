import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'src/config/app_routes.dart';
import 'providers/auth_provider.dart';
import 'providers/information_provider.dart';
import 'providers/krs_provider.dart';
import 'providers/khs_provider.dart';
import 'providers/pembayaran_provider.dart';
import 'providers/kp_provider.dart';
import 'providers/skripsi_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => InformationProvider()),
        ChangeNotifierProvider(create: (_) => KRSProvider()),
        ChangeNotifierProvider(create: (_) => KHSProvider()),
        ChangeNotifierProvider(create: (_) => PembayaranProvider()),
        ChangeNotifierProvider(create: (_) => KPProvider()),
        ChangeNotifierProvider(create: (_) => SkripsiProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Siakad Apps',
        theme: ThemeData(primarySwatch: Colors.blue),
        initialRoute: AppRoutes.login,
        routes: AppRoutes.routes,
      ),
    );
  }
}
