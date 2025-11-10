class InformationModel {
  final String id;
  final String title;
  final String content;
  final String? category;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  InformationModel({
    required this.id,
    required this.title,
    required this.content,
    this.category,
    this.createdAt,
    this.updatedAt,
  });

  factory InformationModel.fromJson(Map<String, dynamic> json) {
    // Handle created_at yang bisa berupa string date atau datetime
    DateTime? parseDate(dynamic value) {
      if (value == null) return null;
      if (value is DateTime) return value;
      if (value is String) {
        // Coba parse sebagai ISO datetime dulu
        var dt = DateTime.tryParse(value);
        if (dt != null) return dt;
        
        // Jika gagal, coba parse sebagai date format YYYY-MM-DD
        if (value.length == 10) {
          // Format: 2024-12-15
          var parts = value.split('-');
          if (parts.length == 3) {
            var year = int.tryParse(parts[0]);
            var month = int.tryParse(parts[1]);
            var day = int.tryParse(parts[2]);
            if (year != null && month != null && day != null) {
              return DateTime(year, month, day);
            }
          }
        }
      }
      return null;
    }

    return InformationModel(
      id: json['id']?.toString() ?? '',
      title: json['title'] ?? json['judul'] ?? '',
      content: json['content'] ?? json['isi'] ?? json['konten'] ?? '',
      category: json['category'] ?? json['kategori'],
      createdAt: parseDate(json['created_at'] ?? json['date']),
      updatedAt: parseDate(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'category': category,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }
}

