import 'package:flutter/material.dart';

/// AppBar untuk halaman Tugas Akhir
PreferredSizeWidget buildAppBar(BuildContext context, {required String title}) {
  return AppBar(
    title: Text(title),
    centerTitle: true,
    backgroundColor: Colors.blue[900],
  );
}

/// Header progres (misalnya status Kerja Praktek / Skripsi)
Widget buildProgressHeader({
  required String title,
  required String status,
  required List<Color> gradientColors,
}) {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      gradient: LinearGradient(colors: gradientColors),
      borderRadius: BorderRadius.circular(12),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          "Status: $status",
          style: const TextStyle(color: Colors.white70, fontSize: 14),
        ),
      ],
    ),
  );
}

/// Row untuk informasi detail
Widget buildInfoRow(String label, String value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
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
        Expanded(
          flex: 3,
          child: Text(value),
        ),
      ],
    ),
  );
}

/// Item timeline (misalnya proses KP/Skripsi)
Widget buildTimelineItem({
  required IconData icon,
  required String title,
  required String date,
  required bool isDone,
}) {
  return ListTile(
    leading: Icon(
      icon,
      color: isDone ? Colors.green : Colors.grey,
    ),
    title: Text(title),
    subtitle: Text(date),
    trailing: Icon(
      isDone ? Icons.check_circle : Icons.radio_button_unchecked,
      color: isDone ? Colors.green : Colors.grey,
    ),
  );
}
