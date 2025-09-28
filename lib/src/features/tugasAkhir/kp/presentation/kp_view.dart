import 'package:flutter/material.dart';
import 'package:siakad_apps/src/widgets/tugas_akhir_widgets.dart';

class KerjaPraktekDetailPage extends StatelessWidget {
  const KerjaPraktekDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, title: "Kerja Praktek"),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildProgressHeader(
              title: "Kerja Praktek",
              status: "DAFTAR JUDUL",
              gradientColors: const [Color(0xFF0D47A1), Color(0xFF1976D2)],
            ),
            const SizedBox(height: 20),
            buildInfoRow("JUDUL KERJA PRAKTEK", "Analisa dan Perancangan Aplikasi Sistem Akademik Berbasis Mobile"),
            buildInfoRow("TEMPAT PENELITIAN", "Fakultas Teknik Universitas Muhammadiyah Tangerang"),
            buildInfoRow("ALAMAT PENELITIAN", "Jalan Perintis Kemerdekaan I Cikokol Tangerang"),
            buildInfoRow("PEMBIMBING", "Syepry Maulana Husain, S.Kom, MTI"),
            const SizedBox(height: 20),
            const Divider(),
            const SizedBox(height: 10),
            buildTimelineItem(icon: Icons.assignment, title: "Pendaftaran Judul", date: "29-10-2024", isDone: true),
            buildTimelineItem(icon: Icons.monetization_on, title: "Verifikasi Keuangan", date: "29-10-2024", isDone: true),
            buildTimelineItem(icon: Icons.check_circle_outline, title: "Verifikasi Akademik", date: "29-10-2024", isDone: false),
          ],
        ),
      ),
    );
  }
}
