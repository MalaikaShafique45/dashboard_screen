import 'package:flutter/material.dart';

class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({super.key});

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  bool _isObscure = true;
  String? _farmType;
  final List<String> _types = ['Crop Farming', 'Mixed Farming', 'Horticulture'];

  @override
  Widget build(BuildContext context) {
    const primary = Color(0xFF76A76F);

    return Scaffold(
      backgroundColor: const Color(0xFFF9F3E5),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          children: [
            const SizedBox(height: 50),
            Align(alignment: Alignment.centerLeft, child: BackButton(color: Colors.black)),
            Image.asset('assets/logo.png', height: 60),
            const Text("Create Account", style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
            const Text("Join our community of farmers", style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 25),

            _input(Icons.person_outline, "Full Name"),
            _input(Icons.email_outlined, "Email Address"),
            _input(Icons.phone_outlined, "Phone Number"),
            _dropdown(Icons.location_on_outlined, "Location/Village", []),
            _dropdown(Icons.eco_outlined, "Farm Type", _types),

            // Password Field
            TextField(
              obscureText: _isObscure,
              decoration: _deco(Icons.lock_outline, "Password").copyWith(
                suffixIcon: IconButton(
                  icon: Icon(_isObscure ? Icons.visibility_off : Icons.visibility),
                  onPressed: () => setState(() => _isObscure = !_isObscure),
                ),
              ),
            ),

            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: primary, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                onPressed: () {},
                child: const Text("Create My Account", style: TextStyle(color: Colors.white, fontSize: 18)),
              ),
            ),

            TextButton(
              onPressed: () {},
              child: const Text.rich(TextSpan(text: "Already have an account? ", style: TextStyle(color: Colors.black), children: [
                TextSpan(text: "Sign In", style: TextStyle(color: primary, fontWeight: FontWeight.bold))
              ])),
            ),
          ],
        ),
      ),
    );
  }

  // Reusable Decoration
  InputDecoration _deco(IconData icon, String hint) => InputDecoration(
    prefixIcon: Icon(icon, color: const Color(0xFF76A76F)),
    hintText: hint,
    filled: true,
    fillColor: Colors.white,
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
    contentPadding: const EdgeInsets.symmetric(vertical: 15),
  );

  Widget _input(IconData icon, String hint) => Padding(
    padding: const EdgeInsets.only(bottom: 12),
    child: TextField(decoration: _deco(icon, hint)),
  );

  Widget _dropdown(IconData icon, String hint, List<String> items) => Padding(
    padding: const EdgeInsets.only(bottom: 12),
    child: DropdownButtonFormField<String>(
      decoration: _deco(icon, hint),
      items: items.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
      onChanged: (v) => setState(() => _farmType = v),
    ),
  );
}