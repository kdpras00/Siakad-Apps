class KHSModel {
  final String id;
  final String semester;
  final double ip;
  final int totalMataKuliah;
  final List<KHSDetailModel> details;

  KHSModel({
    required this.id,
    required this.semester,
    required this.ip,
    required this.totalMataKuliah,
    required this.details,
  });

  factory KHSModel.fromJson(Map<String, dynamic> json) {
    // Handle parsing numerik yang bisa int atau double
    double parseDouble(dynamic value) {
      if (value == null) return 0.0;
      if (value is double) return value;
      if (value is int) return value.toDouble();
      if (value is String) return double.tryParse(value) ?? 0.0;
      return 0.0;
    }

    return KHSModel(
      id: json['id']?.toString() ?? '',
      semester: json['semester'] ?? '',
      ip: parseDouble(json['ip'] ?? json['indeks_prestasi'] ?? 0.0),
      totalMataKuliah: json['total_mata_kuliah'] ?? json['totalMataKuliah'] ?? 0,
      details: (json['details'] as List<dynamic>? ?? [])
          .map((item) => KHSDetailModel.fromJson(item))
          .toList(),
    );
  }
}

class KHSDetailModel {
  final String id;
  final String kodeMataKuliah;
  final String namaMataKuliah;
  final int sks;
  final String nilai;
  final double nilaiAngka;

  KHSDetailModel({
    required this.id,
    required this.kodeMataKuliah,
    required this.namaMataKuliah,
    required this.sks,
    required this.nilai,
    required this.nilaiAngka,
  });

  factory KHSDetailModel.fromJson(Map<String, dynamic> json) {
    // Handle parsing numerik yang bisa int atau double
    double parseDouble(dynamic value) {
      if (value == null) return 0.0;
      if (value is double) return value;
      if (value is int) return value.toDouble();
      if (value is String) return double.tryParse(value) ?? 0.0;
      return 0.0;
    }

    return KHSDetailModel(
      id: json['id']?.toString() ?? '',
      kodeMataKuliah: json['kode_mata_kuliah'] ?? json['kodeMataKuliah'] ?? '',
      namaMataKuliah: json['nama_mata_kuliah'] ?? json['namaMataKuliah'] ?? '',
      sks: json['sks'] ?? 0,
      nilai: json['nilai'] ?? json['nilai_huruf'] ?? '',
      nilaiAngka: parseDouble(json['nilai_angka'] ?? json['nilaiAngka'] ?? 0.0),
    );
  }
}

class KHSRekapModel {
  final double ipk;
  final int totalMataKuliah;
  final List<KHSModel> semesterList;

  KHSRekapModel({
    required this.ipk,
    required this.totalMataKuliah,
    required this.semesterList,
  });

  factory KHSRekapModel.fromJson(Map<String, dynamic> json) {
    // Handle parsing numerik yang bisa int atau double
    double parseDouble(dynamic value) {
      if (value == null) return 0.0;
      if (value is double) return value;
      if (value is int) return value.toDouble();
      if (value is String) return double.tryParse(value) ?? 0.0;
      return 0.0;
    }

    return KHSRekapModel(
      ipk: parseDouble(json['ipk'] ?? 0.0),
      totalMataKuliah: json['total_mata_kuliah'] ?? json['totalMataKuliah'] ?? 0,
      semesterList: (json['semester_list'] as List<dynamic>? ?? [])
          .map((item) => KHSModel.fromJson(item))
          .toList(),
    );
  }
}

