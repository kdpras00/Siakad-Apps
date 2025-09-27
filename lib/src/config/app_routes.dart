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
import '../features/tugas_akhir/kp/presentation/kp_view.dart';
import '../features/tugas_akhir/skripsi/presentation/skripsi_view.dart';

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

  static Map<String, WidgetBuilder> routes = {
    login: (context) => const LoginView(),
    register: (context) => const RegisterView(),
    changePassword: (context) => const ChangePasswordView(),
    dashboard: (context) => const DashboardView(),
    informasi: (context) => const InformasiView(),
    krs: (context) => const KrsView(),
    khs: (context) => const KhsView(),
    pembayaran: (context) => const PembayaranView(),
    kp: (context) => const KpView(),
    skripsi: (context) => const SkripsiView(),
  };
}
