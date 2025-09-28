import 'package:flutter/material.dart';

class SkripsiDetailPage extends StatelessWidget {
  const SkripsiDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Skripsi")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildProgressHeader(
              title: "Skripsi",
              status: "DAFTAR JUDUL",
              gradientColors: const [Color(0xFFFFB300), Color(0xFFFFCC33)],
            ),
            const SizedBox(height: 20),
            buildInfoRow(
              "JUDUL SKRIPSI",
              "Analisa dan Perancangan Aplikasi Sistem Akademik Berbasis Mobile",
            ),
            buildInfoRow(
              "TEMPAT PENELITIAN",
              "Fakultas Teknik Universitas Muhammadiyah Tangerang",
            ),
            buildInfoRow(
              "ALAMAT PENELITIAN",
              "Jalan Perintis Kemerdekaan I Cikokol Tangerang",
            ),
            buildInfoRow("PEMBIMBING", "Syepry Maulana Husain, S.Kom, MTI"),
            const SizedBox(height: 20),
            const Divider(),
            const SizedBox(height: 10),
            buildTimelineItem(
              icon: Icons.assignment,
              title: "Pendaftaran Judul",
              date: "29-10-2024",
              isDone: true,
            ),
            buildTimelineItem(
              icon: Icons.monetization_on,
              title: "Verifikasi Keuangan",
              date: "29-10-2024",
              isDone: true,
            ),
            buildTimelineItem(
              icon: Icons.check_circle_outline,
              title: "Verifikasi Akademik",
              date: "29-10-2024",
              isDone: false,
            ),
          ],
        ),
      ),
    );
  }
}

/// 🔹 Header Kuning (full lebar)
Widget buildProgressHeader({
  required String title,
  required String status,
  required List<Color> gradientColors,
}) {
  return Container(
    width: double.infinity, // <--- biar full lebar
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      gradient: LinearGradient(colors: gradientColors),
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.1),
          blurRadius: 6,
          offset: const Offset(0, 3),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text("Status: $status", style: const TextStyle(color: Colors.white70)),
      ],
    ),
  );
}

/// 🔹 Info Row
Widget buildInfoRow(String label, String value) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 12.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(flex: 3, child: Text(value)),
      ],
    ),
  );
}

/// 🔹 Timeline Item
Widget buildTimelineItem({
  required IconData icon,
  required String title,
  required String date,
  required bool isDone,
}) {
  return ListTile(
    leading: Icon(icon, color: isDone ? Colors.green : Colors.grey),
    title: Text(title),
    subtitle: Text(date),
    trailing: Icon(
      isDone ? Icons.check_circle : Icons.radio_button_unchecked,
      color: isDone ? Colors.green : Colors.grey,
    ),
  );
}
