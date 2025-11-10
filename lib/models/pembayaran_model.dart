class PembayaranModel {
  final String id;
  final String semester;
  final double totalAmount;
  final double paidAmount;
  final double remainingAmount;
  final String status;
  final List<PembayaranDetailModel> details;

  PembayaranModel({
    required this.id,
    required this.semester,
    required this.totalAmount,
    required this.paidAmount,
    required this.remainingAmount,
    required this.status,
    required this.details,
  });

  double get percentage {
    if (totalAmount == 0) return 0;
    return (paidAmount / totalAmount) * 100;
  }

  factory PembayaranModel.fromJson(Map<String, dynamic> json) {
    // Handle parsing numerik yang bisa int atau double
    double parseDouble(dynamic value) {
      if (value == null) return 0.0;
      if (value is double) return value;
      if (value is int) return value.toDouble();
      if (value is String) return double.tryParse(value) ?? 0.0;
      return 0.0;
    }

    final total = parseDouble(json['total_amount'] ?? json['totalAmount'] ?? 0.0);
    final paid = parseDouble(json['paid_amount'] ?? json['paidAmount'] ?? 0.0);
    // Gunakan remaining_amount dari backend jika ada, jika tidak hitung dari total - paid
    final remaining = parseDouble(json['remaining_amount'] ?? json['remainingAmount'] ?? (total - paid));
    
    return PembayaranModel(
      id: json['id']?.toString() ?? '',
      semester: json['semester'] ?? '',
      totalAmount: total,
      paidAmount: paid,
      remainingAmount: remaining,
      status: json['status'] ?? (remaining == 0 ? 'Lunas' : 'Belum Lunas'),
      details: (json['details'] as List<dynamic>? ?? [])
          .map((item) => PembayaranDetailModel.fromJson(item))
          .toList(),
    );
  }
}

class PembayaranDetailModel {
  final String id;
  final String komponen;
  final double total;
  final double paid;
  final double remaining;

  PembayaranDetailModel({
    required this.id,
    required this.komponen,
    required this.total,
    required this.paid,
    required this.remaining,
  });

  factory PembayaranDetailModel.fromJson(Map<String, dynamic> json) {
    // Handle parsing numerik yang bisa int atau double
    double parseDouble(dynamic value) {
      if (value == null) return 0.0;
      if (value is double) return value;
      if (value is int) return value.toDouble();
      if (value is String) return double.tryParse(value) ?? 0.0;
      return 0.0;
    }

    final total = parseDouble(json['total'] ?? 0.0);
    final paid = parseDouble(json['paid'] ?? json['terbayar'] ?? 0.0);
    // Gunakan remaining dari backend jika ada, jika tidak hitung dari total - paid
    final remaining = parseDouble(json['remaining'] ?? (total - paid));
    
    return PembayaranDetailModel(
      id: json['id']?.toString() ?? '',
      komponen: json['komponen'] ?? json['nama_komponen'] ?? '',
      total: total,
      paid: paid,
      remaining: remaining,
    );
  }
}

