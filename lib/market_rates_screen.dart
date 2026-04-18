import 'package:flutter/material.dart';

class MarketRatesScreen extends StatefulWidget {
  const MarketRatesScreen({super.key});

  @override
  State<MarketRatesScreen> createState() => _MarketRatesScreenState();
}

class _MarketRatesScreenState extends State<MarketRatesScreen> {
  // Current category tracking
  String selectedCategory = "All";

  // Updated Data List with Mango, Cotton, and Sugarcane
  final List<Map<String, String>> allCrops = [
    {"name": "Maize (Corn)", "cat": "Grains", "kg": "Rs. 70", "maund": "Rs. 2,800", "market": "Sahiwal", "status": "up", "trend": "بڑھ رہا ہے"},
    {"name": "Wheat", "cat": "Grains", "kg": "Rs. 95", "maund": "Rs. 3,800", "market": "Lahore", "status": "up", "trend": "بڑھ رہا ہے"},
    {"name": "Rice (Basmati)", "cat": "Grains", "kg": "Rs. 280", "maund": "Rs. 11,200", "market": "Karachi", "status": "up", "trend": "بڑھ رہا hai"},
    {"name": "Onion", "cat": "Vegetables", "kg": "Rs. 85", "maund": "Rs. 3,400", "market": "Hyderabad", "status": "down", "trend": "گر رہا ہے"},
    {"name": "Tomato", "cat": "Vegetables", "kg": "Rs. 120", "maund": "Rs. 4,800", "market": "Islamabad", "status": "up", "trend": "بڑھ رہا hai"},
    {"name": "Potato", "cat": "Vegetables", "kg": "Rs. 65", "maund": "Rs. 2,600", "market": "Lahore", "status": "stable", "trend": "مستحکم"},
    // Mango added in Fruits
    {"name": "Mango", "cat": "Fruits", "kg": "Rs. 200", "maund": "Rs. 8,000", "market": "Multan", "status": "up", "trend": "بڑھ رہا ہے"},
    // Cotton & Sugarcane added in Cash Crops
    {"name": "Cotton", "cat": "Cash Crops", "kg": "Rs. 180", "maund": "Rs. 7,200", "market": "Multan", "status": "stable", "trend": "مستحکم"},
    {"name": "Sugarcane", "cat": "Cash Crops", "kg": "Rs. 15", "maund": "Rs. 600", "market": "Faisalabad", "status": "down", "trend": "گر رہا hai"},
    {"name": "Red Chili", "cat": "Spices", "kg": "Rs. 350", "maund": "Rs. 14,000", "market": "Kandh Kot", "status": "stable", "trend": "مستحکم"},
  ];

  @override
  Widget build(BuildContext context) {
    // Logic: Jab 'All' ho to poori list dikhao, warna filter karo
    final List<Map<String, String>> displayedCrops = selectedCategory == "All"
        ? allCrops
        : allCrops.where((crop) => crop['cat'] == selectedCategory).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Market Rates", style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFF1B4332),
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          const SizedBox(height: 15),
          // Horizontal Filter Chips
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: ["All", "Grains", "Vegetables", "Fruits", "Cash Crops", "Spices"]
                  .map((label) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                child: ChoiceChip(
                  label: Text(label),
                  selected: selectedCategory == label,
                  onSelected: (bool selected) {
                    setState(() {
                      selectedCategory = label; // Redraws screen with filtered list
                    });
                  },
                  selectedColor: const Color(0xFF2D6A4F),
                  labelStyle: TextStyle(
                    color: selectedCategory == label ? Colors.white : Colors.black,
                  ),
                ),
              ))
                  .toList(),
            ),
          ),
          const SizedBox(height: 15),
          // Scrollable Data Table
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SingleChildScrollView(
                child: DataTable(
                  columnSpacing: 25,
                  columns: const [
                    DataColumn(label: Text('CROP / فصل')),
                    DataColumn(label: Text('CATEGORY')),
                    DataColumn(label: Text('PER KG')),
                    DataColumn(label: Text('MARKET')),
                    DataColumn(label: Text('TREND')),
                  ],
                  // Crucial: displayedCrops contains the filtered data
                  rows: displayedCrops.map((crop) => DataRow(
                    cells: [
                      DataCell(Text(crop['name']!, style: const TextStyle(fontWeight: FontWeight.w500))),
                      DataCell(Text(crop['cat']!)),
                      DataCell(Text(crop['kg']!)),
                      DataCell(Text(crop['market']!)),
                      DataCell(Row(
                        children: [
                          Icon(Icons.trending_up, size: 14, color: _getTrendColor(crop['status']!)),
                          const SizedBox(width: 4),
                          Text(crop['trend']!, style: TextStyle(color: _getTrendColor(crop['status']!), fontWeight: FontWeight.bold)),
                        ],
                      )),
                    ],
                  )).toList(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _getTrendColor(String status) {
    if (status == "up") return Colors.green;
    if (status == "down") return Colors.red;
    return Colors.grey;
  }
}