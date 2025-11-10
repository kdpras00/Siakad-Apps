import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../providers/information_provider.dart';
import '../../../../models/information_model.dart';

class InformasiPage extends StatefulWidget {
  const InformasiPage({super.key});

  @override
  State<InformasiPage> createState() => _InformasiPageState();
}

class _InformasiPageState extends State<InformasiPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<InformationProvider>(context, listen: false).loadAllInformation();
    });
  }

  @override
  Widget build(BuildContext context) {
    final informationProvider = Provider.of<InformationProvider>(context);

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
          IconButton(
            icon: const Icon(Icons.notifications, color: Colors.grey),
            onPressed: () {
              // Sudah di halaman Informasi; tetap di halaman yang sama
            },
          ),
          const Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: Icon(Icons.account_circle, color: Colors.grey),
          ),
        ],
      ),
      body: informationProvider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : informationProvider.errorMessage != null
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(informationProvider.errorMessage!),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          informationProvider.loadAllInformation();
                        },
                        child: const Text('Coba Lagi'),
                      ),
                    ],
                  ),
                )
              : informationProvider.informationList.isEmpty
                  ? const Center(
                      child: Padding(
                        padding: EdgeInsets.all(32.0),
                        child: Text('Tidak ada informasi'),
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.all(16.0),
                      itemCount: informationProvider.informationList.length,
                      itemBuilder: (context, index) {
                        final information = informationProvider.informationList[index];
                        return InformasiItem(
                          title: information.title,
                          date: information.createdAt != null
                              ? '${information.createdAt!.day} ${_getMonthName(information.createdAt!.month)} ${information.createdAt!.year}'
                              : 'Tanpa tanggal',
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => InformasiDetailPage(information: information),
                              ),
                            );
                          },
                        );
                      },
                    ),
    );
  }

  String _getMonthName(int month) {
    const months = [
      'Januari',
      'Februari',
      'Maret',
      'April',
      'Mei',
      'Juni',
      'Juli',
      'Agustus',
      'September',
      'Oktober',
      'November',
      'Desember',
    ];
    return months[month - 1];
  }
}

// Widget untuk item informasi
class InformasiItem extends StatelessWidget {
  final String title;
  final String date;
  final VoidCallback onTap;

  const InformasiItem({
    super.key,
    required this.title,
    required this.date,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          vertical: 12.0,
          horizontal: 16.0,
        ),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        subtitle: Text(date, style: const TextStyle(color: Colors.grey)),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: onTap,
      ),
    );
  }
}

// Halaman detail informasi
class InformasiDetailPage extends StatelessWidget {
  final InformationModel information;

  const InformasiDetailPage({
    super.key,
    required this.information,
  });

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
        title: const Text(
          'Detail Informasi',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            if (information.category != null)
              Chip(
                label: Text(information.category!),
                backgroundColor: Colors.orange[100],
              ),
            const SizedBox(height: 16),
            Text(
              information.title,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            if (information.createdAt != null)
              Padding(
                padding: const EdgeInsets.only(top: 8, bottom: 16),
                child: Text(
                  '${information.createdAt!.day} ${_getMonthName(information.createdAt!.month)} ${information.createdAt!.year}',
                  style: const TextStyle(color: Colors.grey),
                ),
              ),
            const SizedBox(height: 16),
            Text(
              information.content,
              style: const TextStyle(fontSize: 16, height: 1.5),
            ),
          ],
        ),
      ),
    );
  }

  String _getMonthName(int month) {
    const months = [
      'Januari',
      'Februari',
      'Maret',
      'April',
      'Mei',
      'Juni',
      'Juli',
      'Agustus',
      'September',
      'Oktober',
      'November',
      'Desember',
    ];
    return months[month - 1];
  }
}
