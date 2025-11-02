import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:siakad_apps/providers/krs_provider.dart';
import 'package:siakad_apps/models/krs_model.dart';

class KRSPage extends StatefulWidget {
  const KRSPage({super.key});

  @override
  State<KRSPage> createState() => _KRSPageState();
}

class _KRSPageState extends State<KRSPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<KRSProvider>(context, listen: false).loadAllKRS();
    });
  }

  @override
  Widget build(BuildContext context) {
    final krsProvider = Provider.of<KRSProvider>(context);

    return Scaffold(
      appBar: _buildAppBar(context),
      body: krsProvider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : krsProvider.errorMessage != null
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(krsProvider.errorMessage!),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          krsProvider.loadAllKRS();
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
                      if (krsProvider.krsList.isNotEmpty) _KRSHeader(krs: krsProvider.krsList.first) else const SizedBox(),
                      const SizedBox(height: 20),
                      const Text(
                        'Semua Semester',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Divider(),
                      if (krsProvider.krsList.isEmpty)
                        const Center(
                          child: Padding(
                            padding: EdgeInsets.all(32.0),
                            child: Text('Tidak ada data KRS'),
                          ),
                        )
                      else
                        ...krsProvider.krsList.map((krs) => _buildSemesterItem(
                              context,
                              krs.semester,
                              krs.status,
                              krs.totalSks,
                              isCuti: krs.status.toLowerCase().contains('cuti'),
                            )),
                    ],
                  ),
                ),
    );
  }

  PreferredSizeWidget
  _buildAppBar(
    BuildContext
    context,
  ) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back,
          color: Colors.black,
        ),
        onPressed: () => Navigator.pop(
          context,
        ),
      ),
      title: Row(
        children:
            <
              Widget
            >[
              Image.asset(
                'assets/images/logo_umt.png',
                height: 30,
              ),
              const SizedBox(
                width: 8,
              ),
              const Text(
                'SIAKAD FT',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
      ),
      actions:
          const <
            Widget
          >[
            Padding(
              padding: EdgeInsets.only(
                right: 16.0,
              ),
              child: Icon(
                Icons.notifications,
                color: Colors.grey,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                right: 16.0,
              ),
              child: Icon(
                Icons.account_circle,
                color: Colors.grey,
              ),
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
    Color sksColor = isCuti ? Colors.red[50]! : Colors.green[50]!;

    return Card(
      elevation: 1,
      margin: const EdgeInsets.symmetric(
        vertical: 8,
      ),
      child: ListTile(
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          status,
        ),
        trailing: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 5,
          ),
          decoration: BoxDecoration(
            color: sksColor,
            borderRadius: BorderRadius.circular(
              5,
            ),
          ),
          child: Text(
            '$sks SKS',
            style: TextStyle(
              color: isCuti
                  ? Colors.red[800]
                  : Colors.green[800],
            ),
          ),
        ),
        onTap: () {
          final krsProvider = Provider.of<KRSProvider>(context, listen: false);
          final krs = krsProvider.krsList.firstWhere(
            (k) => k.semester == title,
            orElse: () => krsProvider.krsList.first,
          );
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => KRSDetailPage(krs: krs),
            ),
          );
        },
      ),
    );
  }
}

// ================= HEADER KRS =================
class _KRSHeader extends StatelessWidget {
  final KRSModel? krs;
  
  _KRSHeader({this.krs});

  @override
  Widget
  build(
    BuildContext
    context,
  ) {
    return Container(
      padding: const EdgeInsets.all(
        16.0,
      ),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(
              0xFF4FACFE,
            ), // Soft blue
            Color(
              0xFF6DD5FA,
            ), // Light cyan
            Color(
              0xFFFEE140,
            ), // Vibrant yellow
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(
          16,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(
              0,
              4,
            ),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    krs?.tahunAjaran ?? 'T.A. 2024/2025',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    krs?.semester ?? 'Semester 7',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Chip(
                    label: Text(
                      krs?.status ?? 'Aktif',
                      style: const TextStyle(
                        color: Color(0xFF0C2461),
                      ),
                    ),
                    backgroundColor: Colors.white,
                  ),
                ],
              ),
              Column(
                children: [
                  Text(
                    '${krs?.totalSks ?? 22}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text(
                    'SKS',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ],
      ),
    );
  }
}

// ================= HALAMAN DETAIL KRS =================

class KRSDetailPage extends StatelessWidget {
  final KRSModel krs;
  
  const KRSDetailPage({
    super.key,
    required this.krs,
  });

  @override
  Widget build(BuildContext context) {
    final colors = [
      [const Color(0xFF7B3FF2), const Color(0xFF2E3192)],
      [const Color(0xFFFFC837), const Color(0xFFFF8008)],
      [const Color(0xFF4FACFE), const Color(0xFF00F2FE)],
      [const Color(0xFF43E97B), const Color(0xFF38F9D7)],
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Detail KRS ${krs.semester}',
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
      body: krs.details.isEmpty
          ? const Center(child: Text('Tidak ada mata kuliah'))
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: krs.details.asMap().entries.map((entry) {
                  final index = entry.key;
                  final detail = entry.value;
                  final colorPair = colors[index % colors.length];
                  
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: _buildCourseCard(
                      title: detail.namaMataKuliah,
                      schedule: detail.jadwal,
                      room: detail.ruangan,
                      lecturer: detail.dosen,
                      startColor: colorPair[0],
                      endColor: colorPair[1],
                    ),
                  );
                }).toList(),
              ),
            ),
    );
  }

  Widget _buildCourseCard({
    required String title,
    required String schedule,
    required String room,
    required String lecturer,
    required Color startColor,
    required Color endColor,
  }) {
    const double borderRadiusValue = 16.0;

    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          borderRadiusValue,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            borderRadiusValue,
          ),
          gradient: LinearGradient(
            colors: [
              startColor,
              endColor,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        padding: const EdgeInsets.all(
          16.0,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:
              <
                Widget
              >[
                // Icon (Berada di Kiri)
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withValues(alpha: 0.3),
                  ),
                  child: const Icon(
                    Icons.person,
                    size: 30,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
                // Bagian Teks (Rata Kanan)
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children:
                        <
                          Widget
                        >[
                          Text(
                            title,
                            textAlign: TextAlign.right,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            schedule,
                            textAlign: TextAlign.right,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),
                          Text(
                            room,
                            textAlign: TextAlign.right,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            lecturer,
                            textAlign: TextAlign.right,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                  ),
                ),
              ],
        ),
      ),
    );
  }
}
