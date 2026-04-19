import 'package:flutter/material.dart';
import '../../../../views/ai_chat_screen.dart';
import '../../../../views/iot_sensors_screen.dart';
import '../../../../views/govt_scheme_screen.dart';
import '../../../../views/market_rates_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const primaryGreen = Color(0xFF1B4332);

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        title: const Text("Kisan Sahulat",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: primaryGreen,
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0,
      ),
      drawer: Drawer(
        backgroundColor: const Color(0xFF1B4332), // primaryGreen color
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            // Drawer Header
            const DrawerHeader(
              decoration: BoxDecoration(color: Color(0xFF2D6A4F)),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.eco, color: Colors.white, size: 40),
                    SizedBox(height: 10),
                    Text(
                      "Kisan Sahulat",
                      style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),

            // 1. Home
            _sidebarItem(context, Icons.home, "Home", "ہوم", () => Navigator.pop(context)),

            // 2. AI Chat
            _sidebarItem(context, Icons.chat, "AI Chat", "اے آئی چیٹ", () {
              Navigator.pop(context); // Drawer band karne ke liye
              Navigator.push(context, MaterialPageRoute(builder: (context) => const AiChatScreen()));
            }),

            // 3. IoT Sensors
            _sidebarItem(context, Icons.sensors, "IoT Sensors", "سینسرز", () {
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (context) => const IotSensorsScreen()));
            }),

            // 4. Govt Schemes
            _sidebarItem(context, Icons.account_balance, "Govt Schemes", "سرکاری اسکیمیں", () {
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (context) => const GovtSchemeScreen()));
            }),

            // 5. Market Rates
            _sidebarItem(context, Icons.trending_up, "Market Rates", "منڈی ریٹ", () {
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (context) => const MarketRatesScreen()));
            }),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildBanner(),

            // Yahan se 'const' hata diya gaya hai taake warning na aaye
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children: [
                  _buildMenuCard(context, "AI Chatbot", Icons.chat_bubble_outline, const AiChatScreen(), "اے آئی چیٹ بوٹ"),
                  _buildMenuCard(context, "IoT Sensors", Icons.sensors, const IotSensorsScreen(), "آئی او ٹی سینسرز"),
                  _buildMenuCard(context, "Govt Schemes", Icons.account_balance, const GovtSchemeScreen(), "سرکاری اسکیمیں"),
                  _buildMenuCard(context, "Market Rates", Icons.trending_up, const MarketRatesScreen(), "منڈی ریٹ"),
                ],
              ),
            ),

            const Padding(
              padding: EdgeInsets.fromLTRB(16, 24, 16, 8),
              child: Row(
                children: [
                  Text("Quick Overview ", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  Text("(فوری جائزہ)", style: TextStyle(fontSize: 16, color: Colors.grey)),
                ],
              ),
            ),

            _buildOverviewSection(),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildBanner() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF52B788), Color(0xFF1B4332)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Farmer Chat", style: TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold)),
          SizedBox(height: 5),
          Text("AI-powered support for crops\n(فصلوں کے لیے اے آئی مدد)",
              style: TextStyle(color: Colors.white70, fontSize: 14)),
        ],
      ),
    );
  }

  Widget _buildMenuCard(BuildContext context, String title, IconData icon, Widget screen, String urduSub) {
    return InkWell(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => screen)),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              // withOpacity ki jagah withValues use kiya gaya hai
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 10,
                offset: const Offset(0, 4))
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundColor: const Color(0xFFD8F3DC),
              radius: 25,
              child: Icon(icon, color: const Color(0xFF1B4332), size: 28),
            ),
            const SizedBox(height: 12),
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
            const SizedBox(height: 4),
            Text(urduSub, style: const TextStyle(color: Colors.grey, fontSize: 11)),
          ],
        ),
      ),
    );
  }

  Widget _sidebarItem(BuildContext context, IconData icon, String title, String urdu, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: Colors.white),
      title: Text(title, style: const TextStyle(color: Colors.white)),
      subtitle: Text(urdu, style: const TextStyle(color: Colors.white60, fontSize: 11)),
      onTap: onTap,
    );
  }

  Widget _buildOverviewSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Row(
            children: [
              _overviewBox("Moisture", "65%", "نمی", Icons.water_drop, Colors.blue),
              const SizedBox(width: 8),
              _overviewBox("Temp", "32°C", "درجہ حرارت", Icons.thermostat, Colors.orange),
              const SizedBox(width: 8),
              _overviewBox("Weather", "Sunny", "موسم", Icons.wb_sunny, Colors.amber),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              _overviewBox("Active Crops", "4", "فعال فصلیں", Icons.eco, Colors.green),
              const SizedBox(width: 8),
              _overviewBox("Market Update", "↑ 5%", "منڈی اپڈیٹ", Icons.trending_up, Colors.teal),
              const SizedBox(width: 8),
              const Expanded(child: SizedBox()),
            ],
          ),
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
          border: Border.all(color: Colors.grey.withValues(alpha: 0.1)),
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
}