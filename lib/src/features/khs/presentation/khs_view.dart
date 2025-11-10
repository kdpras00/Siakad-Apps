import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:siakad_apps/providers/khs_provider.dart';
import 'package:siakad_apps/models/khs_model.dart';
import '../../informasi/presentation/informasi_view.dart';

class KHSPage extends StatefulWidget {
  const KHSPage({super.key});

  @override
  State<KHSPage> createState() => _KHSPageState();
}

class _KHSPageState extends State<KHSPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<KHSProvider>(context, listen: false).loadKHSRekap();
    });
  }

  @override
  Widget build(BuildContext context) {
    final khsProvider = Provider.of<KHSProvider>(context);

    return Scaffold(
      appBar: _buildAppBar(context),
      body: khsProvider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : khsProvider.errorMessage != null
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(khsProvider.errorMessage!),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          khsProvider.loadKHSRekap();
                        },
                        child: const Text('Coba Lagi'),
                      ),
                    ],
                  ),
                )
              : SingleChildScrollView(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _buildHeader(khsProvider.rekap),
                      const SizedBox(height: 20),
                      const Text(
                        'Semua Semester',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const Divider(),
                      if (khsProvider.khsList.isEmpty)
                        const Center(
                          child: Padding(
                            padding: EdgeInsets.all(32.0),
                            child: Text('Tidak ada data KHS'),
                          ),
                        )
                      else
                        ...khsProvider.khsList.map((khs) => _buildSemesterKHSItem(
                              context,
                              khs.semester,
                              khs.ip == 0 ? 'Cuti Kuliah' : 'Aktif',
                              khs.ip,
                              isCuti: khs.ip == 0,
                            )),
                    ],
                  ),
                ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.black),
        onPressed: () => Navigator.pop(context),
      ),
      title: Row(
        children: <Widget>[
          Image.asset('assets/images/logo_umt.png', height: 30),
          const SizedBox(width: 8),
          const Text(
            'SIAKAD FT',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ],
      ),
      actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.notifications, color: Colors.grey),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const InformasiPage()),
            );
          },
        ),
        const Padding(
          padding: EdgeInsets.only(right: 16.0),
          child: Icon(Icons.account_circle, color: Colors.grey),
        ),
      ],
    );
  }

  Widget _buildHeader(KHSRekapModel? rekap) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFF4FACFE),
            Color(0xFF6DD5FA),
            Color(0xFFFEE140),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Total Mata Kuliah',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              const SizedBox(height: 4),
              Text(
                '${rekap?.totalMataKuliah ?? 0}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Column(
            children: [
              const Text('IPK', style: TextStyle(color: Colors.white, fontSize: 16)),
              const SizedBox(height: 4),
              Text(
                '${rekap?.ipk.toStringAsFixed(2) ?? '0.00'}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSemesterKHSItem(
    BuildContext context,
    String title,
    String status,
    double ip, {
    bool isCuti = false,
  }) {
    Color ipkColor = isCuti ? Colors.red[200]! : Colors.green[200]!;

    return Card(
      elevation: 1,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(status),
        trailing: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            color: ipkColor,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Text(
            ip.toStringAsFixed(2),
            style: TextStyle(
              color: isCuti ? Colors.red[800] : Colors.green[800],
            ),
          ),
        ),
        onTap: () {
          final khsProvider = Provider.of<KHSProvider>(context, listen: false);
          final khs = khsProvider.khsList.firstWhere(
            (k) => k.semester == title,
            orElse: () => khsProvider.khsList.first,
          );
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => KHSDetailPage(khs: khs),
            ),
          );
        },
      ),
    );
  }
}

class KHSDetailPage extends StatelessWidget {
  final KHSModel khs;

  const KHSDetailPage({super.key, required this.khs});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: khs.details.isEmpty
          ? const Center(child: Text('Tidak ada data'))
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: khs.details.map((detail) => _buildMataKuliahItem(
                      detail.namaMataKuliah,
                      detail.nilai,
                    )).toList(),
              ),
            ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.black),
        onPressed: () => Navigator.pop(context),
      ),
      title: Text(
        'Detail KHS ${khs.semester}',
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildMataKuliahItem(String nama, String nilai) {
    Color nilaiColor = nilai == 'A' ? Colors.green : Colors.amber;

    return Card(
      elevation: 1,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        title: Text(nama, style: const TextStyle(fontWeight: FontWeight.bold)),
        trailing: Text(
          nilai,
          style: TextStyle(
            color: nilaiColor,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
