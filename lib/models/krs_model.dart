class KRSModel {
  final String id;
  final String semester;
  final String tahunAjaran;
  final String status;
  final int totalSks;
  final List<KRSDetailModel> details;

  KRSModel({
    required this.id,
    required this.semester,
    required this.tahunAjaran,
    required this.status,
    required this.totalSks,
    required this.details,
  });

  factory KRSModel.fromJson(Map<String, dynamic> json) {
    return KRSModel(
      id: json['id']?.toString() ?? '',
      semester: json['semester'] ?? '',
      tahunAjaran: json['tahun_ajaran'] ?? json['tahunAjaran'] ?? '',
      status: json['status'] ?? 'Aktif',
      totalSks: json['total_sks'] ?? json['totalSks'] ?? 0,
      details: (json['details'] as List<dynamic>? ?? [])
          .map((item) => KRSDetailModel.fromJson(item))
          .toList(),
    );
  }
}

class KRSDetailModel {
  final String id;
  final String kodeMataKuliah;
  final String namaMataKuliah;
  final int sks;
  final String dosen;
  final String jadwal;
  final String ruangan;

  KRSDetailModel({
    required this.id,
    required this.kodeMataKuliah,
    required this.namaMataKuliah,
    required this.sks,
    required this.dosen,
    required this.jadwal,
    required this.ruangan,
  });

  factory KRSDetailModel.fromJson(Map<String, dynamic> json) {
    return KRSDetailModel(
      id: json['id']?.toString() ?? '',
      kodeMataKuliah: json['kode_mata_kuliah'] ?? json['kodeMataKuliah'] ?? '',
      namaMataKuliah: json['nama_mata_kuliah'] ?? json['namaMataKuliah'] ?? '',
      sks: json['sks'] ?? 0,
      dosen: json['dosen'] ?? json['nama_dosen'] ?? '',
      jadwal: json['jadwal'] ?? json['hari'] ?? '',
      ruangan: json['ruangan'] ?? '',
    );
  }
}

