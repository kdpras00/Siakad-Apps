class UserModel {
  final String id;
  final String name;
  final String nim;
  final String email;
  final String? phone;
  final String programStudi;
  final int semester;
  final String? role;

  UserModel({
    required this.id,
    required this.name,
    required this.nim,
    required this.email,
    this.phone,
    required this.programStudi,
    required this.semester,
    this.role,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    // Handle semester yang bisa berupa string seperti "7 (Tujuh)" atau int
    int parseSemester(dynamic value) {
      if (value is int) return value;
      if (value is String) {
        // Extract angka dari string seperti "7 (Tujuh)" -> 7
        final match = RegExp(r'(\d+)').firstMatch(value);
        if (match != null) {
          return int.tryParse(match.group(1) ?? '0') ?? 0;
        }
        return int.tryParse(value) ?? 0;
      }
      return 0;
    }

    return UserModel(
      id: json['id']?.toString() ?? '',
      name: json['name'] ?? json['nama'] ?? '',
      nim: json['nim'] ?? json['nomor_induk'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? json['handphone'] ?? json['no_hp'],
      programStudi: json['program_studi'] ?? json['prodi'] ?? '',
      semester: parseSemester(json['semester']),
      role: json['role'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'nim': nim,
      'email': email,
      'phone': phone,
      'program_studi': programStudi,
      'semester': semester,
      'role': role,
    };
  }
}

