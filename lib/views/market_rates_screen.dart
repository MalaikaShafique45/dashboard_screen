import 'package:flutter/material.dart';
import '../../../services/api_services.dart'; // Path check kar lein
import '../../../models/market_rate_model.dart';

class MarketRatesScreen extends StatefulWidget {
  const MarketRatesScreen({super.key});

  @override
  State<MarketRatesScreen> createState() => _MarketRatesScreenState();
}

class _MarketRatesScreenState extends State<MarketRatesScreen> {
  String selectedCategory = "All";
  final ApiService apiService = ApiService(); // API Service ka object

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Market Rates", style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFF1B4332),
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          const SizedBox(height: 15),
          // 1. Filter Chips (Same as your design)
          _buildFilterChips(),

          const SizedBox(height: 15),

          // 2. Data Table wrapped in FutureBuilder (Django Connection)
          Expanded(
            child: FutureBuilder<List<MarketRateModel>>(
              future: apiService.fetchMarketRates(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator(color: Color(0xFF1B4332)));
                } else if (snapshot.hasError || !snapshot.hasData) {
                  return const Center(child: Text("Server se rabta nahi ho saka!"));
                }

                // Filtering Logic
                final displayedCrops = selectedCategory == "All"
                    ? snapshot.data!
                    : snapshot.data!.where((crop) => crop.city == selectedCategory).toList();

                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: SingleChildScrollView(
                    child: DataTable(
                      columnSpacing: 25,
                      columns: const [
                        DataColumn(label: Text('CROP / فصل')),
                        DataColumn(label: Text('PRICE')),
                        DataColumn(label: Text('MARKET')),
                      ],
                      rows: displayedCrops.map((crop) => DataRow(
                        cells: [
                          DataCell(Text(crop.cropName, style: const TextStyle(fontWeight: FontWeight.w500))),
                          DataCell(Text("Rs. ${crop.price}")),
                          DataCell(Text(crop.city)),
                        ],
                      )).toList(),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // Helper Widget for Chips to keep code clean
  Widget _buildFilterChips() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: ["All", "Lahore", "Sahiwal", "Multan", "Karachi"]
            .map((label) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5.0),
          child: ChoiceChip(
            label: Text(label),
            selected: selectedCategory == label,
            onSelected: (bool selected) {
              setState(() => selectedCategory = label);
            },
            selectedColor: const Color(0xFF2D6A4F),
            labelStyle: TextStyle(color: selectedCategory == label ? Colors.white : Colors.black),
          ),
        )).toList(),
      ),
    );
  }
}