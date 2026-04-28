import 'package:dashboard_screen/views/create_account_screen.dart';
import 'package:flutter/material.dart';
import 'package:dashboard_screen/features/dashboard/presentation/screens/dashboard_screen.dart';
import 'package:dashboard_screen/features/admin/presentation/screens/admin_dashboard_screen.dart';
import 'services/auth_service.dart';
class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String _selectedRole = "User";

  static const Color primaryGreen = Color(0xFF1B4332);

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
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Banner Section
            Stack(
              children: [
                Container(
                  height: screenHeight * 0.40,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/fields.bg.jpg'),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(50),
                      bottomRight: Radius.circular(50),
                    ),
                  ),
                ),
                Container(
                  height: screenHeight * 0.40,
                  decoration: const BoxDecoration(
                    color: Colors.black45,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(50),
                      bottomRight: Radius.circular(50),
                    ),
                  ),
                ),
                Positioned(
                  top: screenHeight * 0.12,
                  left: 0,
                  right: 0,
                  child: Column(
                    children: const [
                      Icon(Icons.eco, size: 60, color: Colors.white),
                      SizedBox(height: 10),
                      Text("Farmer's Portal", style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
                      Text("(کسانوں کا پورٹل)", style: TextStyle(color: Colors.white70, fontSize: 16)),
                    ],
                  ),
                ),
              ],
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Sign In", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 25),

                  // Email & Password Fields
                  _buildTextField("Email Address", "ای میل", _emailController, Icons.email_outlined),
                  const SizedBox(height: 20),
                  _buildTextField("Password", "پاس ورڈ", _passwordController, Icons.lock_outline, isPassword: true),

                  const SizedBox(height: 30),

                  // --- ROLE SELECTOR (Neeche move kar diya gaya hai) ---
                  const Text("Login As:", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black54)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Radio(
                        value: "User",
                        groupValue: _selectedRole,
                        activeColor: primaryGreen,
                        onChanged: (val) => setState(() => _selectedRole = val.toString()),
                      ),
                      const Text("User"),
                      const SizedBox(width: 30),
                      Radio(
                        value: "Admin",
                        groupValue: _selectedRole,
                        activeColor: primaryGreen,
                        onChanged: (val) => setState(() => _selectedRole = val.toString()),
                      ),
                      const Text("Admin"),
                    ],
                  ),

                  const SizedBox(height: 25),

                  // Login Button
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_selectedRole == "Admin") {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => const AdminDashboardScreen()),
                          );
                        } else {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => const DashboardScreen()),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryGreen,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                      ),
                      child: Text("Sign In as $_selectedRole", style: const TextStyle(color: Colors.white, fontSize: 18)),
                    ),
                  ),

                  const SizedBox(height: 15),

                  // Register Text (Ab iske upar selection hai)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don't have an account?"),
                      TextButton(
                         onPressed: () async {
  
  String email = _emailController.text.trim();
  String password = _passwordController.text.trim();
  if (email.isEmpty || password.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Email aur Password lazmi likhein!")),
    );
    return;
  }

  final AuthService auth = AuthService();
  bool success = await auth.login(email, password);

  if (success) {
    
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const MarketRatesScreen()), // Example
    );
  } else {
    
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Login fail ho gaya! Email ya Password check karein.")),
    );
  }
},
 
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const CreateAccountScreen()));
                        },
                        child: const Text("Register", style: TextStyle(color: primaryGreen, fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, String urduLabel, TextEditingController controller, IconData icon, {bool isPassword = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black54, fontSize: 14)),
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
          ),
        ),
      ],
    );
  }
}
