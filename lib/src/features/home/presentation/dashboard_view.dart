import 'package:flutter/material.dart';
// import '../../../config/app_routes.dart';
import '../../informasi/presentation/informasi_view.dart';
import '../../krs/presentation/krs_view.dart';
import '../../khs/presentation/khs_view.dart';
import '../../pembayaran/presentation/pembayaran_view.dart';
import '../../profile/presentation/profile_view.dart';
import '../../tugasAkhir/presentation/tugas_akhir_view.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
 Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Row(
          children: <Widget>[
            Image.asset('assets/images/logo_umt.png', height: 30),
            const SizedBox(width: 8),
            const Text(
              'SIAKAD FT',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        actions: <Widget>[
          const Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: Icon(Icons.notifications, color: Colors.grey),
          ),
          IconButton(
            icon: const Icon(Icons.account_circle, color: Colors.grey),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProfilePage()),
              );
            },
          ),
        ],
      ),
      body: Stack(
        children: <Widget>[
          // Perbaikan gambar background: menyelaraskan ke bawah
          Align(
            alignment: Alignment.bottomCenter,
            child: Image.asset(
              'assets/images/gedung_umt.png',
              fit: BoxFit.contain, // Menggunakan BoxFit.contain
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 24.0,
              vertical: 20.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    _buildDashboardButton(
                      context,
                      'Informasi',
                      const InformasiPage(),
                    ),
                    _buildDashboardButton(
                      context,
                      'Kartu Rencana Studi',
                      const KRSPage(),
                    ),
                    _buildDashboardButton(
                      context,
                      'Hasil Studi',
                      const KHSPage(),
                    ),
                    _buildDashboardButton(
                      context,
                      'Pembayaran',
                      const PembayaranPage(),
                    ),
                    _buildDashboardButton(
                      context,
                      'Tugas Akhir',
                      const TugasAkhirPage(),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  } 

  Widget _buildDashboardButton(
    BuildContext context,
    String text,
    Widget? destination,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ElevatedButton(
        onPressed: () {
          if (destination != null) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => destination),
            );
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.orange,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.horizontal(left: Radius.circular(25.0)),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
          child: Text(text, style: const TextStyle(color: Colors.white)),
        ),
      ),
    );
  }
} 