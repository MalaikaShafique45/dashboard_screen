import 'package:flutter/material.dart';

class FarmProfileScreen extends StatefulWidget {
  const FarmProfileScreen({super.key});

  @override
  State<FarmProfileScreen> createState() => _FarmProfileScreenState();
}

class _FarmProfileScreenState extends State<FarmProfileScreen> {
  static const Color primaryGreen = Color(0xFF1B4332);
  static const Color bgCream = Color(0xFFF5F3E5);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: bgCream,
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          title: const Text("Farm Profile (فارم پروفائل)",
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          backgroundColor: primaryGreen,
          centerTitle: true,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              // Header Section
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 30),
                decoration: const BoxDecoration(
                  color: primaryGreen,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(40),
                    bottomRight: Radius.circular(40),
                  ),
                ),
                child: const Column(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.white,
                      child: Icon(Icons.person, size: 50, color: primaryGreen),
                    ),
                    SizedBox(height: 15),
                    Text("Malaika Shafique",
                        style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    // Top 3 Lines of Urdu Writing
                    const Text(
                      "خوش آمدید! اپنی پروفائل کو مکمل اور درست رکھیں۔",
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: primaryGreen),
                      textAlign: TextAlign.right,
                    ),
                    const Text(
                      "آپ کی فراہم کردہ معلومات زرعی ماہرین سے رابطے میں مددگار ثابت ہوں گی۔",
                      style: TextStyle(fontSize: 12, color: Colors.black87),
                      textAlign: TextAlign.right,
                    ),
                    const Text(
                      "کسی بھی تبدیلی کے بعد 'محفوظ کریں' کا بٹن دبانا نہ بھولیں۔",
                      style: TextStyle(fontSize: 12, color: Colors.black54),
                      textAlign: TextAlign.right,
                    ),

                    const SizedBox(height: 25),

                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Personal & Farm Details (ذاتی اور فارم کی معلومات)",
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: primaryGreen),
                      ),
                    ),
                    const SizedBox(height: 15),

                    // --- 5 Editable Fields with Urdu Labels ---
                    _buildEditableField("Full Name (مکمل نام)", "Malaika Shafique", Icons.person_outline),
                    _buildEditableField("Farm Name (فارم کا نام)", "Organic Bloom Admin", Icons.agriculture),
                    _buildEditableField("Location (مقام / پتہ)", "Gujranwala, Punjab", Icons.location_on_outlined),
                    _buildEditableField("Total Land (کل زمین)", "12 Acres", Icons.landscape_outlined),
                    _buildEditableField("Contact (رابطہ نمبر)", "+92 300 1234567", Icons.phone_android_outlined),

                    const SizedBox(height: 30),

                    SizedBox(
                      width: double.infinity,
                      height: 55,
                      child: ElevatedButton(
                        onPressed: () {
                          FocusScope.of(context).unfocus();
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Changes Saved! (تبدیلیاں محفوظ کر دی گئیں)"),
                              backgroundColor: Colors.green,
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryGreen,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        child: const Text("Save Changes (محفوظ کریں)",
                            style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEditableField(String label, String initialValue, IconData icon) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 8)],
      ),
      child: TextFormField(
        initialValue: initialValue,
        readOnly: false, // Clickable and supports Laptop Typing
        cursorColor: primaryGreen,
        style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Colors.grey, fontSize: 12),
          prefixIcon: Icon(icon, color: primaryGreen),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        ),
      ),
    );
  }
}