import 'package:flutter/material.dart';
// Added import for ProfilePage to fix navigation
import '../../profile/presentation/profile_view.dart';

class PembayaranPage
    extends
        StatelessWidget {
  const PembayaranPage({
    super.key,
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
          // Changed from Icons.notifications_outlined to Icons.notifications to match standard
          const Padding(
            padding: EdgeInsets.only(
              right: 16.0,
            ),
            child: Icon(
              Icons.notifications,
              color: Colors.grey,
            ),
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
      body: ListView(
        padding: const EdgeInsets.all(
          16.0,
        ),
        children: [
          _buildPaymentCard(
            context: context,
            semester: 'Semester 1',
            percentage: '100 %',
            amount: 'Rp. 10.000.000,-',
            paid: 'Terbayar: 10.000.000',
            remaining: 'Sisa: 0',
            startColor: const Color(
              0xFF4A148C,
            ),
            endColor: const Color(
              0xFFAB47BC,
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          _buildPaymentCard(
            context: context,
            semester: 'Semester 2',
            percentage: '100 %',
            amount: 'Rp. 8.000.000,-',
            paid: 'Terbayar: 8.000.000',
            remaining: 'Sisa: 0',
            startColor: const Color(
              0xFF4A148C,
            ),
            endColor: const Color(
              0xFFAB47BC,
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          _buildPaymentCard(
            context: context,
            semester: 'Semester 3',
            percentage: '100 %',
            amount: 'Rp. 7.850.000,-',
            paid: 'Terbayar: 7.850.000',
            remaining: 'Sisa: 0',
            startColor: const Color(
              0xFF4A148C,
            ),
            endColor: const Color(
              0xFFAB47BC,
            ),
          ),
        ],
      ),
    );
  }

  Widget
  _buildPaymentCard({
    required BuildContext
    context,
    required String
    semester,
    required String
    percentage,
    required String
    amount,
    required String
    paid,
    required String
    remaining,
    required Color
    startColor,
    required Color
    endColor,
  }) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder:
                (
                  context,
                ) => PembayaranDetailPage(
                  semester: semester,
                  amount: amount,
                ),
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
                    semester,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    percentage,
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
                    amount,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    paid,
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 11,
                    ),
                  ),
                  Text(
                    remaining,
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
class PembayaranDetailPage
    extends
        StatelessWidget {
  final String
  semester;
  final String
  amount;

  PembayaranDetailPage({
    super.key,
    required this.semester,
    required this.amount,
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
            const Divider(
              thickness: 1,
              height: 20,
            ),
            // Row 1
            _buildDetailRow(
              'Uang Bangunan',
              'Rp. 3.000.000',
              '3.000.000',
              '0',
            ),
            const SizedBox(
              height: 12,
            ),
            // Row 2
            _buildDetailRow(
              'Biaya SKS',
              'Rp. 3.000.000',
              '2.000.000',
              '0',
            ),
            const SizedBox(
              height: 12,
            ),
            // Row 3
            _buildDetailRow(
              'Uang Bangunan',
              'Rp. 100.000',
              '100.000',
              '0',
            ),
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
