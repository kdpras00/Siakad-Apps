import 'package:flutter/material.dart';

// Import semua view
import '../features/auth/presentation/login_view.dart';
import '../features/auth/presentation/register_view.dart';
import '../features/auth/presentation/change_password_view.dart';
import '../features/home/presentation/dashboard_view.dart';
import '../features/informasi/presentation/informasi_view.dart';
import '../features/krs/presentation/krs_view.dart';
import '../features/khs/presentation/khs_view.dart';
import '../features/pembayaran/presentation/pembayaran_view.dart';
import '../features/tugasAkhir/kp/presentation/kp_view.dart';
import '../features/tugasAkhir/skripsi/presentation/skripsi_view.dart';
import '../features/tugasAkhir/presentation/tugas_akhir_view.dart';


class AppRoutes {
  static const String login = '/login';
  static const String register = '/register';
  static const String changePassword = '/change-password';
  static const String dashboard = '/dashboard';
  static const String informasi = '/informasi';
  static const String krs = '/krs';
  static const String khs = '/khs';
  static const String pembayaran = '/pembayaran';
  static const String kp = '/kp';
  static const String skripsi = '/skripsi';
   static const String tugasAkhir = '/tugas-akhir';

  static Map<String, WidgetBuilder> routes = {
    login: (context) => const LoginPage(),
    register: (context) => const RegistrasiAkunPage(),
    changePassword: (context) => const UbahPasswordPage(),
    dashboard: (context) => const DashboardView(),
    informasi: (context) => const InformasiPage(),
    krs: (context) => const KRSPage(),
    khs: (context) => const KHSPage(),
    pembayaran: (context) => const PembayaranPage(),
    kp: (context) => const KerjaPraktekDetailPage(),
    skripsi: (context) => const SkripsiDetailPage(),
    tugasAkhir: (context) => const TugasAkhirPage()  
  };
}
