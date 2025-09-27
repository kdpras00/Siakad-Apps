import 'package:flutter/material.dart';

// =====================
// Halaman KHS (Kartu Hasil Studi)
// =====================
class KHSPage extends StatelessWidget {
  const KHSPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _buildHeader(),
            const SizedBox(height: 20),
            const Text(
              'Semua Semester',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Divider(),
            // Daftar Semester KHS
            _buildSemesterKHSItem(context, 'Semester 1', 'Aktif', 3.8),
            _buildSemesterKHSItem(context, 'Semester 2', 'Aktif', 3.62),
            _buildSemesterKHSItem(context, 'Semester 3', 'Aktif', 3.38),
            _buildSemesterKHSItem(context, 'Semester 4', 'Aktif', 3.76),
            _buildSemesterKHSItem(context, 'Semester 5', 'Aktif', 3.56),
            _buildSemesterKHSItem(
              context,
              'Semester 6',
              'Cuti Kuliah',
              0,
              isCuti: true,
            ),
            _buildSemesterKHSItem(context, 'Semester 7', 'Aktif', 0),
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
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
      actions: const <Widget>[
        Padding(
          padding: EdgeInsets.only(right: 16.0),
          child: Icon(Icons.notifications, color: Colors.grey),
        ),
        Padding(
          padding: EdgeInsets.only(right: 16.0),
          child: Icon(Icons.account_circle, color: Colors.grey),
        ),
      ],
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF88D3CE), Color(0xFFC7EBDD)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Total Mata Kuliah',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              SizedBox(height: 4),
              Text(
                '112',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Column(
            children: [
              Text(
                'IPK',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              SizedBox(height: 4),
              Text(
                '3.52',
                style: TextStyle(
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
    double ipk, {
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
            ipk.toString(),
            style: TextStyle(
              color: isCuti ? Colors.red[800] : Colors.green[800],
            ),
          ),
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => KHSDetailPage(semester: title),
            ),
          );
        },
      ),
    );
  }
}

// =====================
// Halaman Detail KHS
// =====================
class KHSDetailPage extends StatelessWidget {
  final String semester;

  const KHSDetailPage({super.key, required this.semester});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            _buildMataKuliahItem('Algoritma Pemrograman', 'A'),
            _buildMataKuliahItem('Kalkulus 1', 'B'),
            _buildMataKuliahItem('Arsitektur dan Organisasi Komputer', 'A'),
            _buildMataKuliahItem('Pengantar Teknologi Informasi', 'B'),
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
      title: Text(
        'Detail KHS $semester',
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
