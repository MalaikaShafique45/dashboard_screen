import 'package:flutter/material.dart';

class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({super.key});

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  // Screen colors matching your theme
  final Color primaryGreen = const Color(0xFF7BA76F); // Green shade from your screenshot
  final Color bgCream = const Color(0xFFF9F3E5);
  bool _isObscure = true;
  String? _farmType;
  final List<String> _types = ['Crop Farming', 'Mixed Farming', 'Horticulture'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgCream,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            children: [
              const SizedBox(height: 50),

              // Back Button and Logo as per your screenshot
              Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  color: Colors.black,
                  onPressed: () => Navigator.pop(context),
                ),
              ),
              Image.asset(
                'assets/images/logo.png.png',
                height: 150,
                errorBuilder: (context, error, stackTrace) =>
                const Icon(Icons.agriculture, size: 50, color: Color(0xFF1B4332)),
              ),

              const SizedBox(height: 10),
              const Text(
                "Create Account",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const Text(
                "Join our community of farmers",
                style: TextStyle(color: Colors.black54, fontSize: 14),
              ),

              const SizedBox(height: 25),

              _buildInputField(Icons.person_outline, "Full Name"),
              const SizedBox(height: 15),
              _buildInputField(Icons.email_outlined, "Email Address"),
              const SizedBox(height: 15),
              _buildInputField(Icons.phone_outlined, "Phone Number"),
              const SizedBox(height: 15),
              _buildInputField(Icons.location_on_outlined, "Location/Village"),
              const SizedBox(height: 15),

              // Dropdown for Farm Type
              _buildDropdownField(Icons.agriculture_outlined, "Farm Type"),
              const SizedBox(height: 15),

              // Password Field with Eye Icon
              _buildPasswordField(),

              const SizedBox(height: 30),

              // Create Account Button
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryGreen,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text(
                    "Create My Account",
                    style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),

              const SizedBox(height: 15),

              // Login Redirect
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Already have an account? "),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Text(
                      "Sign In",
                      style: TextStyle(color: primaryGreen, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30), // Bottom padding for keyboard
            ],
          ),
        ),
      ),
    );
  }

  // Helper for normal input fields
  Widget _buildInputField(IconData icon, String hint) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: hint,
          prefixIcon: Icon(icon, color: primaryGreen),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 15),
        ),
      ),
    );
  }

  // Helper for password field
  Widget _buildPasswordField() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        obscureText: _isObscure,
        decoration: InputDecoration(
          hintText: "Password",
          prefixIcon: Icon(Icons.lock_outline, color: primaryGreen),
          suffixIcon: IconButton(
            icon: Icon(_isObscure ? Icons.visibility_off : Icons.visibility),
            onPressed: () => setState(() => _isObscure = !_isObscure),
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 15),
        ),
      ),
    );
  }

  // Helper for dropdown
  Widget _buildDropdownField(IconData icon, String hint) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: _farmType,
          hint: Text(hint),
          isExpanded: true,
          icon: Icon(Icons.arrow_drop_down, color: primaryGreen),
          items: _types.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (newValue) => setState(() => _farmType = newValue),
        ),
      ),
    );
  }
}