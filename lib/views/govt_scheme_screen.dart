import 'package:flutter/material.dart';

class GovtSchemeScreen extends StatefulWidget {
  const GovtSchemeScreen({super.key});

  @override
  State<GovtSchemeScreen> createState() => _GovtSchemeScreenState();
}

class _GovtSchemeScreenState extends State<GovtSchemeScreen> {
  String selectedCategory = "All";

  // Aapke 6 mukammal cards ka data
  final List<Map<String, dynamic>> allSchemes = [
    {
      "title": "Crop Insurance Scheme",
      "urduTitle": "فصل بیمہ اسکیم",
      "category": "Insurance",
      "desc": "Compensation for crop losses due to natural disasters.",
      "eligibility": "رجسٹرڈ کسان جو مخصوص فصلیں اگاتے ہیں۔",
      "deadline": "Sep 15, 2026",
      "icon": Icons.security,
      "color": Colors.blue,
    },
    {
      "title": "Kisan Package Subsidy",
      "urduTitle": "کسان پیکیج سبسڈی پروگرام",
      "category": "Subsidy",
      "desc": "Subsidies on fertilizers, seeds and equipment.",
      "eligibility": "5 ایکڑ یا اس سے کم زمین والے کسان۔",
      "deadline": "Jun 30, 2026",
      "icon": Icons.card_giftcard,
      "color": Colors.orange,
    },
    {
      "title": "Tractor Subsidy Program",
      "urduTitle": "ٹریکٹر سبسڈی پروگرام",
      "category": "Subsidy",
      "desc": "50% subsidy on tractor purchase for small farmers.",
      "eligibility": "12.5 ایکڑ سے کم زمین والے کسان۔",
      "deadline": "Aug 30, 2026",
      "icon": Icons.agriculture,
      "color": const Color(0xFF2D6A4F),
    },
    {
      "title": "Free Seed Distribution",
      "urduTitle": "مفت بیج تقسیم پروگرام",
      "category": "Subsidy",
      "desc": "Distribution of free high-quality seeds.",
      "eligibility": "سندھ کے رجسٹرڈ کسان۔",
      "deadline": "Apr 15, 2026",
      "icon": Icons.psychology, // Fixed Icon
      "color": Colors.green,
    },
    {
      "title": "Farmer Training Program",
      "urduTitle": "کسان تربیتی پروگرام",
      "category": "Training",
      "desc": "Free training on modern agriculture techniques.",
      "eligibility": "تمام کسان شرکت کر سکتے ہیں۔",
      "deadline": "Ongoing",
      "icon": Icons.model_training,
      "color": Colors.teal,
    },
    {
      "title": "Agricultural Loan Scheme",
      "urduTitle": "زرعی قرضہ اسکیم - ZTBL",
      "category": "Loans",
      "desc": "Low interest loans for equipment and cultivation.",
      "eligibility": "پاکستانی شہری اور زمین کے کاغذات لازمی ہیں۔",
      "deadline": "Dec 31, 2026",
      "icon": Icons.account_balance,
      "color": Colors.deepPurple,
    },
  ];

  @override
  Widget build(BuildContext context) {
    // Filtering Logic
    List<Map<String, dynamic>> displayedSchemes = selectedCategory == "All"
        ? allSchemes
        : allSchemes.where((s) => s['category'] == selectedCategory).toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        title: const Text("Government Schemes", style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF1B4332),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Column(
        children: [
          // Filter Chips Section
          Container(
            height: 65,
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                _buildFilterChip("All"),
                _buildFilterChip("Subsidy"),
                _buildFilterChip("Loans"),
                _buildFilterChip("Insurance"),
                _buildFilterChip("Training"),
              ],
            ),
          ),

          // Schemes List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: displayedSchemes.length,
              itemBuilder: (context, index) {
                final scheme = displayedSchemes[index];
                return _buildSchemeCard(scheme);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String category) {
    bool isSelected = selectedCategory == category;
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: ChoiceChip(
        label: Text(category),
        selected: isSelected,
        onSelected: (bool selected) {
          setState(() {
            selectedCategory = category;
          });
        },
        selectedColor: const Color(0xFF2D6A4F),
        labelStyle: TextStyle(color: isSelected ? Colors.white : Colors.black),
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
    );
  }

  Widget _buildSchemeCard(Map<String, dynamic> scheme) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05), // Latest Fix
            blurRadius: 10,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(scheme['icon'], color: scheme['color'], size: 28),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(scheme['title'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    Text(scheme['urduTitle'], style: const TextStyle(color: Colors.grey, fontSize: 14)),
                  ],
                ),
              ),
              const Chip(
                label: Text("Active", style: TextStyle(color: Colors.green, fontSize: 10)),
                backgroundColor: Color(0xFFE8F5E9),
              ),
            ],
          ),
          const Divider(height: 24),
          Text(scheme['desc'], style: const TextStyle(color: Colors.black87, fontSize: 13)),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(color: const Color(0xFFF1F3F5), borderRadius: BorderRadius.circular(8)),
            child: Row(
              children: [
                const Text("Eligibility: ", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                Expanded(child: Text(scheme['eligibility'], style: const TextStyle(fontSize: 12))),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              const Icon(Icons.calendar_today, size: 14, color: Colors.grey),
              const SizedBox(width: 5),
              Text("Deadline: ${scheme['deadline']}", style: const TextStyle(color: Colors.grey, fontSize: 12)),
            ],
          ),
        ],
      ),
    );
  }
}