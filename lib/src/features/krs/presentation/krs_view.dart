import 'package:flutter/material.dart';

// ================= HALAMAN KRS =================
class KRSPage extends StatelessWidget {
  const KRSPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const _KRSHeader(),
            const SizedBox(height: 20),
            const Text(
              'Semua Semester',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Divider(),
            _buildSemesterItem(context, 'Semester 1', 'Aktif', 22),
            _buildSemesterItem(context, 'Semester 2', 'Aktif', 22),
            _buildSemesterItem(context, 'Semester 3', 'Aktif', 22),
            _buildSemesterItem(context, 'Semester 4', 'Aktif', 22),
            _buildSemesterItem(context, 'Semester 5', 'Aktif', 22),
            _buildSemesterItem(context, 'Semester 6', 'Cuti Kuliah', 0, isCuti: true),
            _buildSemesterItem(context, 'Semester 7', 'Aktif', 22),
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

  Widget _buildSemesterItem(
    BuildContext context,
    String title,
    String status,
    int sks, {
    bool isCuti = false,
  }) {
    Color statusColor = isCuti ? Colors.red[200]! : Colors.green[200]!;
    Color sksColor = isCuti ? Colors.red[50]! : Colors.green[50]!;

    return Card(
      elevation: 1,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(status),
        trailing: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            color: sksColor,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Text(
            '$sks SKS',
            style: TextStyle(
              color: isCuti ? Colors.red[800] : Colors.green[800],
            ),
          ),
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const KRSDetailPage()),
          );
        },
      ),
    );
  }
}

// ================= HEADER KRS =================
class _KRSHeader extends StatelessWidget {
  const _KRSHeader();

  @override
  Widget build(BuildContext context) {
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
              Text('T.A. 2024/2025',
                  style: TextStyle(color: Colors.white, fontSize: 16)),
              SizedBox(height: 4),
              Text(
                'Semester 7',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Chip(
                label: Text('Aktif', style: TextStyle(color: Colors.black)),
                backgroundColor: Colors.white,
              ),
            ],
          ),
          Column(
            children: [
              Text(
                '22',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text('SKS',
                  style: TextStyle(color: Colors.white, fontSize: 16)),
            ],
          ),
        ],
      ),
    );
  }
}

// ================= HALAMAN DETAIL KRS =================
class KRSDetailPage extends StatelessWidget {
  const KRSDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Detail KRS',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            _buildCourseCard(
              title: 'Mobile Programming',
              schedule: 'Senin, 08:30 - 10:00 WIB',
              room: 'Ruang A12.7',
              lecturer: 'Syepry Maulana Husain, S.Kom, MTI',
              cardColor: const Color(0xFF5E2BFF),
            ),
            const SizedBox(height: 16),
            _buildCourseCard(
              title: 'Analisis dan Perancangan\nSistem Informasi',
              schedule: 'Senin, 08:30 - 10:00 WIB',
              room: 'Ruang A12.7',
              lecturer: 'Yani Sugiani, M.Kom',
              cardColor: const Color(0xFFFF9933),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCourseCard({
    required String title,
    required String schedule,
    required String room,
    required String lecturer,
    required Color cardColor,
  }) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient: LinearGradient(
            colors: [cardColor.withOpacity(0.8), cardColor],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Icon(Icons.person, size: 50, color: Colors.white),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      )),
                  const SizedBox(height: 8),
                  Text(schedule,
                      style: const TextStyle(
                          color: Colors.white70, fontSize: 14)),
                  Text(room,
                      style: const TextStyle(
                          color: Colors.white70, fontSize: 14)),
                  const SizedBox(height: 8),
                  Text(lecturer,
                      style: const TextStyle(
                          color: Colors.white, fontSize: 14)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
