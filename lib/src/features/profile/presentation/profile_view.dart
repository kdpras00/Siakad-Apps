import 'package:flutter/material.dart';
// Asumsi path import ini benar dari struktur proyek Anda
import '../../auth/presentation/change_password_view.dart';
import '../../auth/presentation/login_view.dart';

class ProfilePage
    extends
        StatelessWidget {
  const ProfilePage({
    super.key,
  });

  // Data yang disalin dari gambar
  static const String
  _name =
      'Shevrie Maulana Husain';
  static const String
  _nim =
      '0419108607';
  static const String
  _email =
      'syepry.maulana@umt.ac.id';
  static const String
  _handphone =
      '081282xxxx98';
  static const String
  _programStudi =
      'Teknik Informatika';
  static const String
  _semester =
      '7 (Tujuh)';

  // Warna yang mendekati desain
  static const Color
  _primaryColor = Color(
    0xFF0C2461,
  ); // Biru Tua
  static const Color
  _accentColor = Color(
    0xFFFFCC00,
  ); // Kuning/Emas

  @override
  Widget
  build(
    BuildContext
    context,
  ) {
    return Scaffold(
      // AppBar custom dengan gradient dan judul 'Profile'
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(
          80.0,
        ),
        child: AppBar(
          backgroundColor: _primaryColor,
          elevation: 0,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  _primaryColor,
                  Color(
                    0xFF285694,
                  ),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          centerTitle: true,
          title: const Padding(
            padding: EdgeInsets.only(
              top: 30.0,
            ),
            child: Text(
              'Profile',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
      body: Column(
        children:
            <
              Widget
            >[
              // Bagian Atas: Info Profil dengan Gradient
              Container(
                height:
                    MediaQuery.of(
                      context,
                    ).size.height *
                    0.25,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(
                        0xFF285694,
                      ),
                      _accentColor,
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      // Icon Profil Putih
                      CircleAvatar(
                        radius: 40,
                        backgroundColor: Colors.white,
                        child: Icon(
                          Icons.person,
                          size: 50,
                          color: _primaryColor,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      // Nama Pengguna
                      Text(
                        _name,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      // NIM
                      Text(
                        _nim,
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Bagian Bawah: Detail dan Tombol
              Expanded(
                child: Container(
                  color: _accentColor, // Latar belakang kuning/emas
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24.0,
                      vertical: 16.0,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children:
                          <
                            Widget
                          >[
                            // Card putih untuk detail profil
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16.0,
                                vertical: 10.0,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(
                                  16,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(
                                      0.2,
                                    ),
                                    spreadRadius: 1,
                                    blurRadius: 5,
                                    offset: const Offset(
                                      0,
                                      3,
                                    ),
                                  ),
                                ],
                              ),
                              child: Column(
                                children: [
                                  _buildProfileRow(
                                    'Email',
                                    _email,
                                  ),
                                  const Divider(
                                    height: 1,
                                    thickness: 1,
                                  ),
                                  _buildProfileRow(
                                    'Handphone',
                                    _handphone,
                                  ),
                                  const Divider(
                                    height: 1,
                                    thickness: 1,
                                  ),
                                  _buildProfileRow(
                                    'Program Studi',
                                    _programStudi,
                                  ),
                                  const Divider(
                                    height: 1,
                                    thickness: 1,
                                  ),
                                  _buildProfileRow(
                                    'Semester',
                                    _semester,
                                  ),
                                ],
                              ),
                            ),

                            const SizedBox(
                              height: 30,
                            ),

                            // Tombol Ubah Password
                            Container(
                              height: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                  16,
                                ),
                                border: Border.all(
                                  color: Colors.white,
                                  width: 0,
                                ), // Outline Biru Tua
                              ),
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      // Hapus 'const' untuk mengatasi error
                                      builder:
                                          (
                                            context,
                                          ) => UbahPasswordPage(),
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white, // Latar belakang Putih
                                  foregroundColor: Colors.black, // Teks hitam
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 16,
                                  ),
                                  elevation: 0, // Hilangkan shadow
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                      16,
                                    ),
                                  ),
                                ),
                                child: const Text(
                                  'Ubah Password',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(
                              height: 10,
                            ),

                            // Tombol Logout
                            SizedBox(
                              height: 50,
                              child: ElevatedButton(
                                onPressed: () {
                                  // Tampilkan Dialog Konfirmasi Logout
                                  showDialog(
                                    context: context,
                                    builder:
                                        (
                                          BuildContext context,
                                        ) {
                                          return AlertDialog(
                                            title: const Text(
                                              'Konfirmasi Logout',
                                            ),
                                            content: const Text(
                                              'Apakah Anda yakin ingin keluar dari aplikasi?',
                                            ),
                                            actions:
                                                <
                                                  Widget
                                                >[
                                                  TextButton(
                                                    child: const Text(
                                                      'Batal',
                                                    ),
                                                    onPressed: () => Navigator.of(
                                                      context,
                                                    ).pop(),
                                                  ),
                                                  TextButton(
                                                    child: const Text(
                                                      'Logout',
                                                    ),
                                                    onPressed: () {
                                                      Navigator.of(
                                                        context,
                                                      ).pop();
                                                      Navigator.pushAndRemoveUntil(
                                                        context,
                                                        MaterialPageRoute(
                                                          // Hapus 'const' untuk mengatasi error
                                                          builder:
                                                              (
                                                                context,
                                                              ) => LoginPage(),
                                                        ),
                                                        (
                                                          Route<
                                                            dynamic
                                                          >
                                                          route,
                                                        ) => false,
                                                      );
                                                    },
                                                  ),
                                                ],
                                          );
                                        },
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: _primaryColor, // Latar belakang Biru Tua
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 16,
                                  ),
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                      16,
                                    ),
                                  ),
                                ),
                                child: const Text(
                                  'LOGOUT',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                    ),
                  ),
                ),
              ),
            ],
      ),
    );
  }

  // Widget Pembantu untuk menampilkan Detail Profil dalam satu baris
  Widget
  _buildProfileRow(
    String
    label,
    String
    value,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 8.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children:
            <
              Widget
            >[
              // Label (Warna Abu-abu)
              Text(
                label,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 15,
                ),
              ),
              // Nilai (Bold)
              Text(
                value,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            ],
      ),
    );
  }
}
