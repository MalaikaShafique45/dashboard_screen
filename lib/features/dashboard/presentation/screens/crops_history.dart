import 'package:flutter/material.dart';
class CropsHistoryScreen extends StatelessWidget {
  const CropsHistoryScreen({super.key});

  static const Color primaryGreen = Color(0xFF1B4332);
  static const Color bgCream = Color(0xFFF5F3E5);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgCream,
      appBar: AppBar(
        title: const Text("Crops History",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
        backgroundColor: primaryGreen,
        centerTitle: true,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.only(bottom: 25, left: 16, right: 16, top: 10),
                decoration: const BoxDecoration(
                  color: primaryGreen,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                ),
                child: Column(
                  children: <Widget>[
                    const Text("(فصلوں کا ریکارڈ)", style: TextStyle(color: Colors.white70, fontSize: 14)),
                    const SizedBox(height: 15),
                    Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.9),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: const TextField(
                        decoration: InputDecoration(
                          hintText: "Search Crops...",
                          prefixIcon: Icon(Icons.search, color: Colors.grey),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(vertical: 10),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: <Widget>[
                          _buildSummaryCard(Icons.grid_view, "5", "Total Fields"),
                          _buildSummaryCard(Icons.calendar_month, "Rabi", "Season"),
                          _buildSummaryCard(Icons.refresh, "2 days ago", "Updated"),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column( // Replaced ListView with Column to avoid Scroll physics warnings
                  children: <Widget>[
                    _buildCropCard("Wheat (گندم)", "Active", "12 Nov 2025", Colors.green),
                    _buildCropCard("Cotton (کپاس)", "Harvested", "12 Nov 2025", Colors.red),
                    _buildCropCard("Wheat (گندم)", "Harvested", "12 Nov 2025", Colors.red),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSummaryCard(IconData icon, String value, String label) {
    return Container(
      width: 100,
      margin: const EdgeInsets.only(right: 10),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15)),
      child: Column(
        children: <Widget>[
          Icon(icon, color: primaryGreen, size: 22),
          const SizedBox(height: 5),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
          Text(label, style: const TextStyle(fontSize: 9, color: Colors.black54)),
        ],
      ),
    );
  }

  Widget _buildCropCard(String name, String status, String date, Color statusColor) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFEEEEEE), width: 0.5),
      ),
      child: ListTile(
        leading: const CircleAvatar(
          backgroundColor: Color(0xFFE8F5E9),
          child: Icon(Icons.eco, color: primaryGreen, size: 20),
        ),
        title: Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text("Status: $status\nDate: $date"),
        trailing: Icon(Icons.arrow_forward_ios, size: 14, color: statusColor),
      ),
    );
  }
}