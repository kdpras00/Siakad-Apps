import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:siakad_apps/providers/skripsi_provider.dart';
import 'package:siakad_apps/models/skripsi_model.dart';

class SkripsiDetailPage extends StatefulWidget {
  const SkripsiDetailPage({super.key});

  @override
  State<SkripsiDetailPage> createState() => _SkripsiDetailPageState();
}

class _SkripsiDetailPageState extends State<SkripsiDetailPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<SkripsiProvider>(context, listen: false).loadSkripsi();
    });
  }

  @override
  Widget build(BuildContext context) {
    final skripsiProvider = Provider.of<SkripsiProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Skripsi"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: skripsiProvider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : skripsiProvider.errorMessage != null
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(skripsiProvider.errorMessage!),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          skripsiProvider.loadSkripsi();
                        },
                        child: const Text('Coba Lagi'),
                      ),
                    ],
                  ),
                )
              : skripsiProvider.skripsi == null
                  ? const Center(
                      child: Padding(
                        padding: EdgeInsets.all(32.0),
                        child: Text('Belum ada data Skripsi'),
                      ),
                    )
                  : SingleChildScrollView(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          buildProgressHeader(
                            title: "Skripsi",
                            status: skripsiProvider.skripsi!.status,
                            gradientColors: const [Color(0xFFFFB300), Color(0xFFFFCC33)],
                          ),
                          const SizedBox(height: 20),
                          buildInfoRow(
                            "JUDUL SKRIPSI",
                            skripsiProvider.skripsi!.judul,
                          ),
                          buildInfoRow(
                            "TEMPAT PENELITIAN",
                            skripsiProvider.skripsi!.tempatPenelitian,
                          ),
                          buildInfoRow(
                            "ALAMAT PENELITIAN",
                            skripsiProvider.skripsi!.alamatPenelitian,
                          ),
                          buildInfoRow("PEMBIMBING", skripsiProvider.skripsi!.pembimbing),
                          const SizedBox(height: 20),
                          const Divider(),
                          const SizedBox(height: 10),
                          if (skripsiProvider.skripsi!.timeline.isEmpty)
                            const Center(
                              child: Padding(
                                padding: EdgeInsets.all(16.0),
                                child: Text('Belum ada timeline'),
                              ),
                            )
                          else
                            ...skripsiProvider.skripsi!.timeline.map((item) => buildTimelineItem(
                                  icon: _getIconFromName(item.iconName),
                                  title: item.stepName,
                                  date: item.stepDate,
                                  isDone: item.isDone,
                                )),
                        ],
                      ),
                    ),
    );
  }

  IconData _getIconFromName(String iconName) {
    switch (iconName) {
      case 'assignment':
        return Icons.assignment;
      case 'monetization_on':
        return Icons.monetization_on;
      case 'check_circle_outline':
        return Icons.check_circle_outline;
      case 'description':
        return Icons.description;
      case 'presentation':
        return Icons.slideshow;
      default:
        return Icons.assignment;
    }
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
