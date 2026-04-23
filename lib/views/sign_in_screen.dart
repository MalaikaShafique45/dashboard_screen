import 'package:flutter/material.dart';
import '../features/dashboard/presentation/screens/dashboard_screen.dart'; // Standard Relative Path
import 'create_account_screen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  // Logic Variables
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  // Custom Styles
  static const Color primaryGreen = Color(0xFF1B4332);
  static const Color bgCream = Color(0xFFF9F3E5);

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true, // Keyboard aany par screen adjust ho
      body: SingleChildScrollView(
        //physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                // 1. Top Image Header (Lush fields_bg.jpg)
                Container(
                  height: screenHeight * 0.45,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/fields.bg.jpg'), // <--- Check path
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(50),
                      bottomRight: Radius.circular(50),
                    ),
                  ),
                ),

                // 2. Translucent Overlay for Text Visibility
                Container(
                  height: screenHeight * 0.45,
                  decoration: const BoxDecoration(
                    color: Colors.black45,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(50),
                      bottomRight: Radius.circular(50),
                    ),
                  ),
                ),

                // 3. Logo, Text & Language (Farmer's Portal)
                Positioned(
                  top: screenHeight * 0.15,
                  left: 0,
                  right: 0,
                  child: Column(
                    children: const [
                      Icon(Icons.eco, size: 70, color: Colors.white),
                      SizedBox(height: 10),
                      // CHANGED: 'Welcome Back' to 'Farmer's Portal'
                      Text("Farmer's Portal",
                          style: TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold)),
                      // CHANGED: Urdu Text
                      Text("(کسانوں کا پورٹل)",
                          style: TextStyle(color: Colors.white70, fontSize: 18)),
                    ],
                  ),
                ),
              ],
            ),

            // 4. White Curved Container for Input Fields
            Transform.translate(
              offset: const Offset(0, -50), // Overlaps the bottom of the image
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 30),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Sign In", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 25),

                    // Email Field
                    _buildTextField("Email Address", "ای میل (Email)", _emailController, Icons.email_outlined),
                    const SizedBox(height: 20),
                    // Password Field
                    _buildTextField("Password", "پاس ورڈ (Password)", _passwordController, Icons.lock_outline, isPassword: true),

                    const SizedBox(height: 35),

                    // Sign In Button
                    SizedBox(
                      width: double.infinity,
                      height: 55,
                      child: ElevatedButton(
                        onPressed: () {
                          // FIX: Navigation logic is simplified and functional
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => DashboardScreen())
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryGreen,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                          elevation: 3,
                        ),
                        child: const Text("Sign In",
                            style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Registration Text
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Don't have an account?"),
                        TextButton(
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const CreateAccountScreen()));
                          },
                          child: const Text("Register",
                              style: TextStyle(color: primaryGreen, fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- Helper Widget for Input Fields ---
  Widget _buildTextField(String label, String urduLabel, TextEditingController controller, IconData icon, {bool isPassword = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black54)),
            Text(urduLabel, style: const TextStyle(color: Colors.grey, fontSize: 12)),
          ],
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          obscureText: isPassword,
          decoration: InputDecoration(
            prefixIcon: Icon(icon, color: primaryGreen),
            filled: true,
            fillColor: const Color(0xFFF5F7F9),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide.none),
            contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 15),
          ),
        ),
      ],
    );
  }
}