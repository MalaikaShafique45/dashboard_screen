import 'package:flutter/material.dart';

// Screens in the same folder
import 'crops_history.dart';
import 'farm_profile_screen.dart';
import 'expert_help.dart';
import 'admin_dashboard_screen.dart';
import 'settings_screen.dart';
import '../../../../views/sign_in_screen.dart';

// Screens in the views folder
import '../../../../views/ai_chat_screen.dart';
import '../../../../views/iot_sensors_screen.dart';
import '../../../../views/govt_scheme_screen.dart';
import '../../../../views/market_rates_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const Color primaryGreen = Color(0xFF1B4332);
    const Color bgCream = Color(0xFFF9F3E5);

    return Scaffold(
      backgroundColor: bgCream,
      appBar: AppBar(
        title: const Text("Farm with AI", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: primaryGreen,
        centerTitle: true,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        // Actions wala block yahan se khatam kar diya gaya hai
      ),
      drawer: Drawer(
        backgroundColor: bgCream,
        child: Column(
          children: <Widget>[
            const UserAccountsDrawerHeader(
              decoration: BoxDecoration(color: primaryGreen),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(Icons.person, color: primaryGreen, size: 40),
              ),
              accountName: Text("Malaika Shafique",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              accountEmail: Text("ID: 1230100670 | Verified Farmer"),
            ),
            _sidebarItem(context, Icons.history, "Crops History", "فصلوں کا ریکارڈ", () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const CropsHistoryScreen()));
            }),
            _sidebarItem(context, Icons.agriculture, "Farm Profile", "فارم پروفائل", () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const FarmProfileScreen()));
            }),
            _sidebarItem(context, Icons.contact_support_outlined, "Expert Help", "ماہرین کی مدد", () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const ExpertHelpScreen()));
            }),
            _sidebarItem(context, Icons.admin_panel_settings_outlined, "Admin Panel", "ایڈمن پینل", () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const AdminDashboardScreen()));
            }),
            _sidebarItem(context, Icons.settings, "Settings", "ترتیبات", () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const SettingsScreen()));
            }),
            const Divider(),
            // Sidebar mein Logout Button
            _sidebarItem(context, Icons.exit_to_app, "Logout", "لاگ آؤٹ", () {
              _showLogoutDialog(context);
            }),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildBanner(),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children: <Widget>[
                  _buildMenuCard(context, "Agri Dost AI", Icons.smart_toy, const AiChatScreen(), "ایگری دوست (چیٹ)", Colors.orange),
                  _buildMenuCard(context, "Mandi Rates", Icons.trending_up, const MarketRatesScreen(), "منڈی ریٹ (تازہ ترین)", Colors.green),
                  _buildMenuCard(context, "Kisan Rahnumai", Icons.account_balance, const GovtSchemeScreen(), "کسان رہنمائی (اسکیمیں)", Colors.brown),
                  _buildMenuCard(context, "Smart Farm (IoT)", Icons.sensors, const IotSensorsScreen(), "سمارٹ فارم (سینسرز)", Colors.teal),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(16, 24, 16, 8),
              child: Row(
                children: <Widget>[
                  Text("Quick Overview ", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF1B4332))),
                  Text("(فوری جائزہ)", style: TextStyle(fontSize: 16, color: Colors.grey)),
                ],
              ),
            ),
            _buildOverviewSection(),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  // --- Logout Dialog Function ---
  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text("Logout", style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
        content: const Text("Are you sure you want to logout?\nکیا آپ لاگ آؤٹ کرنا چاہتے ہیں؟"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel (کینسل)", style: TextStyle(color: Colors.grey)),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context); // Dialog band karein
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const SignInScreen()),
                    (route) => false,
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text("Yes (جی ہاں)", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  // --- Helper Widgets ---
  Widget _buildBanner() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [Color(0xFF2D6A4F), Color(0xFF1B4332)]),
        borderRadius: BorderRadius.circular(25),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Assalam-o-Alaikum,", style: TextStyle(color: Colors.white70, fontSize: 16)),
          Text("Malaika Shafique", style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          Text("Kheti bari ke sawalat ke liye Agri Dost se rabta karein.", style: TextStyle(color: Colors.white70, fontSize: 12)),
        ],
      ),
    );
  }

  Widget _buildMenuCard(BuildContext context, String title, IconData icon, Widget screen, String urdu, Color col) {
    return InkWell(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => screen)),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 8, offset: const Offset(0, 4))],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: col, size: 35),
            const SizedBox(height: 10),
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Color(0xFF1B4332))),
            Text(urdu, style: const TextStyle(color: Colors.grey, fontSize: 10)),
          ],
        ),
      ),
    );
  }

  Widget _buildOverviewSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          _overviewBox("Moisture", "65%", "نمی", Icons.water_drop, Colors.blue),
          const SizedBox(width: 10),
          _overviewBox("Temp", "32°C", "درجہ حرارت", Icons.thermostat, Colors.orange),
          const SizedBox(width: 10),
          _overviewBox("Weather", "Sunny", "موسم", Icons.wb_sunny, Colors.amber),
        ],
      ),
    );
  }

  Widget _overviewBox(String title, String val, String urdu, IconData icon, Color col) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.grey.withOpacity(0.1)),
        ),
        child: Column(
          children: [
            Icon(icon, color: col, size: 22),
            const SizedBox(height: 8),
            Text(val, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
            const SizedBox(height: 2),
            Text(title, style: const TextStyle(fontSize: 10, color: Colors.black54)),
            Text(urdu, style: const TextStyle(fontSize: 9, color: Colors.grey)),
          ],
        ),
      ),
    );
  }

  Widget _sidebarItem(BuildContext context, IconData icon, String title, String urduText, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: const Color(0xFF1B4332)),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(urduText),
      onTap: onTap,
    );
  }
}