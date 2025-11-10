import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:siakad_apps/providers/pembayaran_provider.dart';
import 'package:siakad_apps/models/pembayaran_model.dart';
import '../../profile/presentation/profile_view.dart';
import '../../informasi/presentation/informasi_view.dart';

class PembayaranPage extends StatefulWidget {
  const PembayaranPage({super.key});

  @override
  State<PembayaranPage> createState() => _PembayaranPageState();
}

class _PembayaranPageState extends State<PembayaranPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<PembayaranProvider>(context, listen: false).loadAllPembayaran();
    });
  }

  @override
  Widget build(BuildContext context) {
    final pembayaranProvider = Provider.of<PembayaranProvider>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        // Added back button and moved logo to title section
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(
              context,
            );
          },
        ),
        // Moved logo to title section to accommodate back button
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
                    fontSize: 18,
                  ),
                ),
              ],
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.notifications,
              color: Colors.grey,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const InformasiPage(),
                ),
              );
            },
          ),
          // Changed from Icons.account_circle_outlined to Icons.account_circle to match standard
          IconButton(
            icon: const Icon(
              Icons.account_circle,
              color: Colors.grey,
            ),
            onPressed: () {
              // Added navigation to profile page to match standard behavior
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (
                        context,
                      ) => const ProfilePage(),
                ),
              );
            },
          ),
        ],
      ),
      body: pembayaranProvider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : pembayaranProvider.errorMessage != null
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(pembayaranProvider.errorMessage!),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          pembayaranProvider.loadAllPembayaran();
                        },
                        child: const Text('Coba Lagi'),
                      ),
                    ],
                  ),
                )
              : pembayaranProvider.pembayaranList.isEmpty
                  ? const Center(
                      child: Padding(
                        padding: EdgeInsets.all(32.0),
                        child: Text('Tidak ada data pembayaran'),
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.all(16.0),
                      itemCount: pembayaranProvider.pembayaranList.length,
                      itemBuilder: (context, index) {
                        final pembayaran = pembayaranProvider.pembayaranList[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: _buildPaymentCard(
                            context: context,
                            pembayaran: pembayaran,
                            startColor: const Color(0xFF4A148C),
                            endColor: const Color(0xFFAB47BC),
                          ),
                        );
                      },
                    ),
    );
  }

  Widget _buildPaymentCard({
    required BuildContext context,
    required PembayaranModel pembayaran,
    required Color startColor,
    required Color endColor,
  }) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PembayaranDetailPage(pembayaran: pembayaran),
          ),
        );
      },
      child: Container(
        height: 120,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              startColor,
              endColor,
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(
            16,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.purple.withOpacity(
                0.3,
              ),
              blurRadius: 8,
              offset: const Offset(
                0,
                4,
              ),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(
            20.0,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Bagian Kiri
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    pembayaran.semester,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${pembayaran.percentage.toStringAsFixed(0)}%',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              // Bagian Kanan
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Rp. ${pembayaran.totalAmount.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')},-',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Terbayar: ${pembayaran.paidAmount.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}',
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 11,
                    ),
                  ),
                  Text(
                    'Sisa: ${pembayaran.remainingAmount.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}',
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Halaman Detail Pembayaran
class PembayaranDetailPage extends StatelessWidget {
  final PembayaranModel pembayaran;

  PembayaranDetailPage({
    super.key,
    required this.pembayaran,
  });

  @override
  Widget
  build(
    BuildContext
    context,
  ) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
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
        title: const Text(
          'Detail Pembayaran',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(
          20.0,
        ),
        child: Column(
          children: [
            // Header Table
            Row(
              children: const [
                Expanded(
                  flex: 3,
                  child: Text(
                    'KOMPONEN',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    'TERBAYAR',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Text(
                    'SISA',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
            const Divider(thickness: 1, height: 20),
            if (pembayaran.details.isEmpty)
              const Text('Tidak ada detail pembayaran')
            else
              ...pembayaran.details.map((detail) => Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: _buildDetailRow(
                      detail.komponen,
                      'Rp. ${detail.total.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}',
                      detail.paid.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.'),
                      detail.remaining.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.'),
                    ),
                  )),
          ],
        ),
      ),
    );
  }

  Widget
  _buildDetailRow(
    String
    component,
    String
    total,
    String
    paid,
    String
    remaining,
  ) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                component,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
              Text(
                total,
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(
            paid,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.green,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Text(
            remaining,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.red,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }
}
