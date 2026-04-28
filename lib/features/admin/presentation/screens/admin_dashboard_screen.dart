import 'package:dashboard_screen/features/admin/presentation/screens/admin_mandi_rates.dart';
import 'package:dashboard_screen/features/admin/presentation/screens/admin_settings.dart';
import 'package:dashboard_screen/features/admin/presentation/screens/help_desk.dart';
import 'package:dashboard_screen/features/admin/presentation/screens/users_request_handling.dart';
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
        iconTheme: const IconThemeData(color: Colors.white),
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
                  Text("Welcome, Admin!",
                      style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                  SizedBox(height: 4),
                  Text("خوش آمدید، ایڈمن!",
                      style: TextStyle(color: Colors.white70, fontSize: 14)),
                ],
              ),
            ),

            const SizedBox(height: 25),

            const Text("MAIN TOOLS / اہم ٹولز",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF1B4332))),
            const SizedBox(height: 15),

            // Grid View
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 15,
              mainAxisSpacing: 15,
              children: [
                // --- 1. USER REQUESTS CARD ---
                _adminCard(
                  context,
                  "User Requests",
                  "صارفین کی درخواستیں",
                  Icons.person_add,
                  Colors.blue,
                      () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const UserRequestHandling()),
                    );
                  },
                ),

                // --- 2. MANDI RATES CARD ---
                _adminCard(
                  context,
                  "Mandi Rates",
                  "منڈی ریٹس",
                  Icons.trending_up,
                  Colors.orange,
                      () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const AdminMandiRates()),
                    );
                  },
                ),

                // --- 3. SETTINGS CARD ---
                _adminCard(
                  context,
                  "Settings",
                  "سیٹنگز",
                  Icons.settings,
                  Colors.blueGrey,
                      () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const AdminSettings()),
                    );
                  },
                ),

                // --- 4. HELP DESK CARD ---
                _adminCard(
                  context,
                  "Help Desk",
                  "ہیلپ ڈیسک",
                  Icons.contact_support,
                  Colors.teal,
                      () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const HelpDesk()),
                    );
                  },
                ),
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

  // Helper Widget for Cards
  Widget _adminCard(BuildContext context, String eng, String urdu, IconData icon, Color color, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(15),
      child: Container(
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
            Text(eng, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
            const SizedBox(height: 2),
            Text(urdu, style: const TextStyle(color: Colors.grey, fontSize: 11)),
          ],
        ),
      ),
    );
  }

  // Helper Widget for Stats
  Widget _statTile(String engLabel, String urduLabel, String count) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        title: Text(engLabel, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        subtitle: Text(urduLabel, style: const TextStyle(fontSize: 12, color: Colors.grey)),
        trailing: Text(count, style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF1B4332), fontSize: 20)),
      ),
    );
  }
}