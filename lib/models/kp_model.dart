class KPModel {
  final int id;
  final String judul;
  final String tempatPenelitian;
  final String alamatPenelitian;
  final String pembimbing;
  final String status;
  final List<KPTimelineItem> timeline;

  KPModel({
    required this.id,
    required this.judul,
    required this.tempatPenelitian,
    required this.alamatPenelitian,
    required this.pembimbing,
    required this.status,
    required this.timeline,
  });

  factory KPModel.fromJson(Map<String, dynamic> json) {
    return KPModel(
      id: json['id'] ?? 0,
      judul: json['judul'] ?? '',
      tempatPenelitian: json['tempat_penelitian'] ?? '',
      alamatPenelitian: json['alamat_penelitian'] ?? '',
      pembimbing: json['pembimbing'] ?? '',
      status: json['status'] ?? 'DAFTAR JUDUL',
      timeline: (json['timeline'] as List<dynamic>?)
              ?.map((item) => KPTimelineItem.fromJson(item))
              .toList() ??
          [],
    );
  }
}

class KPTimelineItem {
  final String stepName;
  final String stepDate;
  final bool isDone;
  final String iconName;

  KPTimelineItem({
    required this.stepName,
    required this.stepDate,
    required this.isDone,
    required this.iconName,
  });

  factory KPTimelineItem.fromJson(Map<String, dynamic> json) {
    return KPTimelineItem(
      stepName: json['step_name'] ?? '',
      stepDate: json['step_date'] ?? '',
      isDone: json['is_done'] ?? false,
      iconName: json['icon_name'] ?? 'assignment',
    );
  }
}

