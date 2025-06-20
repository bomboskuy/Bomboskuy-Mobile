import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' as fbAuth;
import 'package:cloud_firestore/cloud_firestore.dart';


class ProfileScreen extends StatefulWidget {
  final Function(String) onNavigate;

  const ProfileScreen({
    Key? key,
    required this.onNavigate,
  }) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _isEditing = false;
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _birthDateController = TextEditingController();

  fbAuth.User? _firebaseUser;
  final _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    _firebaseUser = fbAuth.FirebaseAuth.instance.currentUser;
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    if (_firebaseUser == null) return;
    final doc = await _firestore.collection('users').doc(_firebaseUser!.uid).get();
    final data = doc.data();

    if (data != null) {
      setState(() {
        _nameController.text = data['name'] ?? '';
        _emailController.text = data['email'] ?? '';
        _phoneController.text = data['phone'] ?? '';
        _birthDateController.text = data['birthDate'] ?? '';
      });
    }
  }

  Future<void> _handleSave() async {
    if (_firebaseUser == null) return;

    await _firestore.collection('users').doc(_firebaseUser!.uid).set({
      'name': _nameController.text.trim(),
      'email': _emailController.text.trim(),
      'phone': _phoneController.text.trim(),
      'birthDate': _birthDateController.text.trim(),
    });

    setState(() => _isEditing = false);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Profil berhasil diperbarui')),
    );
  }

  void _handleLogout() async {
    await fbAuth.FirebaseAuth.instance.signOut();
    widget.onNavigate("login");
  }

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        _birthDateController.text = "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
      });
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _birthDateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: Column(
        children: [
          // Header
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 3,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () => widget.onNavigate("products"),
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.grey[100],
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Icon(Icons.arrow_back, size: 20, color: Colors.grey),
                          ),
                        ),
                        const SizedBox(width: 16),
                        const Text(
                          'Profil Pengguna',
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    if (!_isEditing)
                      GestureDetector(
                        onTap: () => setState(() => _isEditing = true),
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.orange[100],
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Icon(Icons.edit, size: 20, color: Colors.orange),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),

          // Content
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  // Profile Card
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.1),
                            spreadRadius: 1,
                            blurRadius: 5,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Column(
                          children: [
                            // Avatar
                            Column(
                              children: [
                                Container(
                                  width: 96,
                                  height: 96,
                                  decoration: BoxDecoration(
                                    color: Colors.orange[100],
                                    borderRadius: BorderRadius.circular(48),
                                  ),
                                  child: const Icon(Icons.person, size: 48, color: Colors.orange),
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  _nameController.text.isNotEmpty ? _nameController.text : "Nama Pengguna",
                                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            const SizedBox(height: 24),

                            // Profile Fields
                            Expanded(
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    _buildProfileField("Nama Lengkap", _nameController),
                                    const SizedBox(height: 16),
                                    _buildProfileField("Email", _emailController, inputType: TextInputType.emailAddress),
                                    const SizedBox(height: 16),
                                    _buildProfileField("Nomor Telepon", _phoneController, inputType: TextInputType.phone),
                                    const SizedBox(height: 16),
                                    _buildDateField("Tanggal Lahir"),
                                  ],
                                ),
                              ),
                            ),

                            if (_isEditing) ...[
                              const SizedBox(height: 24),
                              Row(
                                children: [
                                  Expanded(
                                    child: ElevatedButton.icon(
                                      onPressed: _handleSave,
                                      icon: const Icon(Icons.save, size: 16),
                                      label: const Text('Simpan'),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.green,
                                        foregroundColor: Colors.white,
                                        padding: const EdgeInsets.symmetric(vertical: 12),
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: OutlinedButton.icon(
                                      onPressed: () => setState(() => _isEditing = false),
                                      icon: const Icon(Icons.close, size: 16),
                                      label: const Text('Batal'),
                                      style: OutlinedButton.styleFrom(
                                        foregroundColor: Colors.grey[600],
                                        side: BorderSide(color: Colors.grey[300]!),
                                        padding: const EdgeInsets.symmetric(vertical: 12),
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: _handleLogout,
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.red[600],
                        side: BorderSide(color: Colors.red[300]!),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      child: const Text('Keluar', style: TextStyle(fontWeight: FontWeight.w600)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileField(String label, TextEditingController controller,
      {TextInputType inputType = TextInputType.text}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Colors.grey[600])),
        const SizedBox(height: 4),
        _isEditing
            ? TextField(
                controller: controller,
                keyboardType: inputType,
                decoration: _inputDecoration(),
              )
            : Text(
                controller.text.isNotEmpty ? controller.text : "Belum diisi",
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
      ],
    );
  }

  Widget _buildDateField(String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Colors.grey[600])),
        const SizedBox(height: 4),
        _isEditing
            ? GestureDetector(
                onTap: _selectDate,
                child: AbsorbPointer(
                  child: TextField(
                    controller: _birthDateController,
                    decoration: _inputDecoration().copyWith(suffixIcon: const Icon(Icons.calendar_today)),
                  ),
                ),
              )
            : Text(
                _birthDateController.text.isNotEmpty ? _birthDateController.text : "Belum diisi",
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
      ],
    );
  }

  InputDecoration _inputDecoration() {
    return InputDecoration(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.grey[300]!)),
      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.grey[300]!)),
      focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.orange)),
    );
  }
}
