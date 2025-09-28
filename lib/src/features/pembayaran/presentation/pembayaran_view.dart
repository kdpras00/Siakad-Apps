import 'package:flutter/material.dart';

class PembayaranPage extends StatelessWidget {
  const PembayaranPage({super.key});

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
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: <Widget>[
          PembayaranItem(
            title: 'SPP Semester 1',
            amount: 'Rp 5.000.000',
            status: 'Belum Lunas',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const PembayaranDetailPage(
                    title: 'SPP Semester 1',
                    amount: 'Rp 5.000.000',
                    status: 'Belum Lunas',
                    description: 'Batas pembayaran sampai 30 Oktober 2024',
                  ),
                ),
              );
            },
          ),
          PembayaranItem(
            title: 'SPP Semester 2',
            amount: 'Rp 5.200.000',
            status: 'Lunas',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const PembayaranDetailPage(
                    title: 'SPP Semester 2',
                    amount: 'Rp 5.200.000',
                    status: 'Lunas',
                    description: 'Pembayaran telah dikonfirmasi.',
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

// Widget untuk item pembayaran
class PembayaranItem extends StatelessWidget {
  final String title;
  final String amount;
  final String status;
  final VoidCallback onTap;

  const PembayaranItem({
    super.key,
    required this.title,
    required this.amount,
    required this.status,
    required this.onTap,
  });

  Color getStatusColor() {
    if (status.toLowerCase() == 'lunas') {
      return Colors.green;
    } else {
      return Colors.red;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
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
        subtitle: Text(amount, style: const TextStyle(color: Colors.black87)),
        trailing: Text(
          status,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: getStatusColor(),
          ),
        ),
        onTap: onTap,
      ),
    );
  }
}

// Halaman detail pembayaran
class PembayaranDetailPage extends StatelessWidget {
  final String title;
  final String amount;
  final String status;
  final String description;

  const PembayaranDetailPage({
    super.key,
    required this.title,
    required this.amount,
    required this.status,
    required this.description,
  });

  Color getStatusColor() {
    if (status.toLowerCase() == 'lunas') {
      return Colors.green;
    } else {
      return Colors.red;
    }
  }

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
          'Detail Pembayaran',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              title,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Text(
              'Jumlah: $amount',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 12),
            Text(
              'Status: $status',
              style: TextStyle(
                fontSize: 18,
                color: getStatusColor(),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              description,
              style: const TextStyle(fontSize: 16, color: Colors.black87),
            ),
          ],
        ),
      ),
    );
  }
}
