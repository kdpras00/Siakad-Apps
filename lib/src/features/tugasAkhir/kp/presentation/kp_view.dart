import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:siakad_apps/providers/kp_provider.dart';
import 'package:siakad_apps/models/kp_model.dart';

class KerjaPraktekDetailPage extends StatefulWidget {
  const KerjaPraktekDetailPage({super.key});

  @override
  State<KerjaPraktekDetailPage> createState() => _KerjaPraktekDetailPageState();
}

class _KerjaPraktekDetailPageState extends State<KerjaPraktekDetailPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<KPProvider>(context, listen: false).loadKerjaPraktek();
    });
  }

  @override
  Widget build(BuildContext context) {
    final kpProvider = Provider.of<KPProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Kerja Praktek"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: kpProvider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : kpProvider.errorMessage != null
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(kpProvider.errorMessage!),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          kpProvider.loadKerjaPraktek();
                        },
                        child: const Text('Coba Lagi'),
                      ),
                    ],
                  ),
                )
              : kpProvider.kp == null
                  ? const Center(
                      child: Padding(
                        padding: EdgeInsets.all(32.0),
                        child: Text('Belum ada data Kerja Praktek'),
                      ),
                    )
                  : SingleChildScrollView(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          buildProgressHeader(
                            title: "Kerja Praktek",
                            status: kpProvider.kp!.status,
                            gradientColors: const [Color(0xFF0D47A1), Color(0xFF1976D2)],
                          ),
                          const SizedBox(height: 20),
                          buildInfoRow(
                            "JUDUL KERJA PRAKTEK",
                            kpProvider.kp!.judul,
                          ),
                          buildInfoRow(
                            "TEMPAT PENELITIAN",
                            kpProvider.kp!.tempatPenelitian,
                          ),
                          buildInfoRow(
                            "ALAMAT PENELITIAN",
                            kpProvider.kp!.alamatPenelitian,
                          ),
                          buildInfoRow("PEMBIMBING", kpProvider.kp!.pembimbing),
                          const SizedBox(height: 20),
                          const Divider(),
                          const SizedBox(height: 10),
                          if (kpProvider.kp!.timeline.isEmpty)
                            const Center(
                              child: Padding(
                                padding: EdgeInsets.all(16.0),
                                child: Text('Belum ada timeline'),
                              ),
                            )
                          else
                            ...kpProvider.kp!.timeline.map((item) => buildTimelineItem(
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

/// 🔹 Header biru (sudah dilebarkan full)
Widget buildProgressHeader({
  required String title,
  required String status,
  required List<Color> gradientColors,
}) {
  return Container(
    width: double.infinity, // <- biar full lebar
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
