import 'package:flutter/material.dart';

class AdminMandiRates extends StatefulWidget {
  const AdminMandiRates({super.key});

  @override
  State<AdminMandiRates> createState() => _AdminMandiRatesState();
}

class _AdminMandiRatesState extends State<AdminMandiRates> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _itemNameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  String selectedCity = 'Gujranwala';
  String selectedCategory = 'Grains / اناج'; // Default Category

  final List<String> cities = ['Gujranwala', 'Lahore', 'Sialkot', 'Faisalabad', 'Multan'];

  // Har kism ki cheez cover karne ke liye categories
  final List<String> categories = [
    'Grains / اناج',
    'Vegetables / سبزیاں',
    'Fruits / پھل',
    'Fertilizers / کھاد',
    'Pesticides / ادویات'
  ];

  void _updateRate() {
    if (_formKey.currentState!.validate()) {
      // Yahan logic aaye gi jo Django Database mein data save kare gi
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("${_itemNameController.text} rates updated!"),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    const Color primaryGreen = Color(0xFF1B4332);

    return Scaffold(
      backgroundColor: const Color(0xFFF9F3E5),
      appBar: AppBar(
        backgroundColor: primaryGreen,
        title: const Text("Update Mandi Rates", style: TextStyle(color: Colors.white)),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Manage Everything / ہر چیز مینیج کریں",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: primaryGreen)),
              const SizedBox(height: 20),

              // 1. Category Dropdown
              _buildLabel("Select Category / زمرہ منتخب کریں"),
              DropdownButtonFormField<String>(
                value: selectedCategory,
                decoration: _inputDecoration(),
                items: categories.map((c) => DropdownMenuItem(value: c, child: Text(c))).toList(),
                onChanged: (value) => setState(() => selectedCategory = value!),
              ),
              const SizedBox(height: 15),

              // 2. City Dropdown
              _buildLabel("Select City / شہر"),
              DropdownButtonFormField<String>(
                value: selectedCity,
                decoration: _inputDecoration(),
                items: cities.map((city) => DropdownMenuItem(value: city, child: Text(city))).toList(),
                onChanged: (value) => setState(() => selectedCity = value!),
              ),
              const SizedBox(height: 15),

              // 3. Item Name
              _buildLabel("Item Name / چیز کا نام"),
              TextFormField(
                controller: _itemNameController,
                decoration: _inputDecoration(hint: "e.g. Tomato, Urea, Wheat"),
                validator: (value) => value!.isEmpty ? "Enter name" : null,
              ),
              const SizedBox(height: 15),

              // 4. Price
              _buildLabel("Price / قیمت"),
              TextFormField(
                controller: _priceController,
                keyboardType: TextInputType.number,
                decoration: _inputDecoration(hint: "Price per unit"),
                validator: (value) => value!.isEmpty ? "Enter price" : null,
              ),
              const SizedBox(height: 30),

              // Update Button
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: _updateRate,
                  style: ElevatedButton.styleFrom(
                      backgroundColor: primaryGreen,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))
                  ),
                  child: const Text("UPDATE DATABASE",
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, letterSpacing: 1.2)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper Methods for UI
  Widget _buildLabel(String text) => Padding(
    padding: const EdgeInsets.only(bottom: 5, left: 2),
    child: Text(text, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
  );

  InputDecoration _inputDecoration({String? hint}) => InputDecoration(
    hintText: hint,
    fillColor: Colors.white,
    filled: true,
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
    contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
  );
}