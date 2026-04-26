import 'package:flutter/material.dart';

class AdminDashboardScreen extends StatelessWidget {
  const AdminDashboardScreen({super.key});
  final Color primaryGreen = const Color(0xFF1B4332);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F3E5),
      appBar: AppBar(
        backgroundColor: primaryGreen,
        title: const Text(
          "Admin Dashboard / ایڈمن ڈیش بورڈ",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- Welcome Header ---
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: primaryGreen,
                borderRadius: BorderRadius.circular(15),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // English: Larger (20)
                  Text("Welcome, Admin!",
                      style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                  SizedBox(height: 4),
                  // Urdu: Smaller (14)
                  Text("خوش آمدید، ایڈمن!",
                      style: TextStyle(color: Colors.white70, fontSize: 14)),
                ],
              ),
            ),

            const SizedBox(height: 25),

            const Text("MAIN TOOLS / اہم ٹولز",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF1B4332))),
            const SizedBox(height: 15),

            // grid view //
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 15,
              mainAxisSpacing: 15,
              children: [
                _adminCard("New Farmers", "نئی رجسٹریشن", Icons.person_add, Colors.blue),
                _adminCard("Mandi Rates", "منڈی ریٹس", Icons.trending_up, Colors.orange),
                _adminCard("Settings", "ایڈمن سیٹنگز", Icons.settings, Colors.blueGrey),
                _adminCard("Help Desk", "ہیلپ ڈیسک", Icons.contact_support, Colors.teal),
              ],
            ),

            const SizedBox(height: 25),

            // --- Statistics Section ---
            const Text("STATISTICS / رپورٹ",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),

            _statTile("Total Farmers", "کل کسان", "1,240"),
            _statTile("Pending", "پینڈنگ رجسٹریشن", "15"),
          ],
        ),
      ),
    );
  }

  // Helper Widget for Grid Cards (English Big, Urdu Small)
  Widget _adminCard(String eng, String urdu, IconData icon, Color color) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 35, color: color),
          const SizedBox(height: 12),
          // English: Larger (16)
          Text(eng, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 2),
          // Urdu: Smaller (12)
          Text(urdu, style: const TextStyle(color: Colors.grey, fontSize: 12)),
        ],
      ),
    );
  }

  // Helper Widget for Stats (English Big, Urdu Small)
  Widget _statTile(String engLabel, String urduLabel, String count) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        title: Text(engLabel, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        subtitle: Text(urduLabel, style: const TextStyle(fontSize: 12, color: Colors.grey)),
        trailing: Text(count, style: TextStyle(fontWeight: FontWeight.bold, color: primaryGreen, fontSize: 20)),
      ),
    );
  }
}