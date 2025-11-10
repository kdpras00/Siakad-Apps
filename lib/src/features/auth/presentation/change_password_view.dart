import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../providers/auth_provider.dart';

class UbahPasswordPage extends StatefulWidget {
  const UbahPasswordPage({super.key});

  @override
  State<UbahPasswordPage> createState() => _UbahPasswordPageState();
}

class _UbahPasswordPageState extends State<UbahPasswordPage> {
  bool _showOld = false;
  bool _showNew = false;
  bool _showConfirm = false;

  final _formKey = GlobalKey<FormState>();
  final _oldController = TextEditingController();
  final _newController = TextEditingController();
  final _confirmController = TextEditingController();

  @override
  void dispose() {
    _oldController.dispose();
    _newController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Ubah Password',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const Text(
              'Masukkan password lama dan password baru Anda',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 20),
            const Text('Password Lama', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFormField(
                    controller: _oldController,
                    obscureText: !_showOld,
                    enableSuggestions: false,
                    autocorrect: false,
                    decoration: InputDecoration(
                      hintText: '••••••••',
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                      suffixIcon: IconButton(
                        icon: Icon(_showOld ? Icons.visibility_off : Icons.visibility),
                        onPressed: () => setState(() => _showOld = !_showOld),
                      ),
                    ),
                    validator: (v) {
                      if (v == null || v.isEmpty) return 'Password lama wajib diisi';
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  const Text('Password Baru', style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _newController,
                    obscureText: !_showNew,
                    enableSuggestions: false,
                    autocorrect: false,
                    decoration: InputDecoration(
                      hintText: '••••••••',
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                      suffixIcon: IconButton(
                        icon: Icon(_showNew ? Icons.visibility_off : Icons.visibility),
                        onPressed: () => setState(() => _showNew = !_showNew),
                      ),
                    ),
                    validator: (v) {
                      if (v == null || v.isEmpty) return 'Password baru wajib diisi';
                      if (v.length < 6) return 'Minimal 6 karakter';
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  const Text('Konfirmasi Password Baru', style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _confirmController,
                    obscureText: !_showConfirm,
                    enableSuggestions: false,
                    autocorrect: false,
                    decoration: InputDecoration(
                      hintText: '••••••••',
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                      suffixIcon: IconButton(
                        icon: Icon(_showConfirm ? Icons.visibility_off : Icons.visibility),
                        onPressed: () => setState(() => _showConfirm = !_showConfirm),
                      ),
                    ),
                    validator: (v) {
                      if (v == null || v.isEmpty) return 'Konfirmasi password wajib diisi';
                      if (v != _newController.text) return 'Konfirmasi tidak cocok';
                      return null;
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
            Consumer<AuthProvider>(
              builder: (context, auth, _) => ElevatedButton(
                onPressed: auth.isLoading
                    ? null
                    : () async {
                        if (!_formKey.currentState!.validate()) return;
                        final ok = await auth.changePassword(
                          _oldController.text,
                          _newController.text,
                        );
                        if (!mounted) return;
                        if (ok) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Password berhasil diubah'),
                              backgroundColor: Colors.green,
                            ),
                          );
                          Navigator.pop(context);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(auth.errorMessage ?? 'Gagal mengubah password'),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                      },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                child: Text(auth.isLoading ? 'Menyimpan...' : 'Simpan', style: const TextStyle(fontSize: 18)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
