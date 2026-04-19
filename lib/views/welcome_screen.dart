import 'package:flutter/material.dart';
import '../features/dashboard/presentation/screens/dashboard_screen.dart';
import 'create_account_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1B4332),
      body: Column(
        children: [
          // --- TOP SECTION (Image Background) ---
          Expanded(
            flex: 6,
            child: Stack(
              children: [
                Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/fields.bg.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(color: Colors.black.withValues(alpha: 0.2)),
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20),
                        const Row(
                          children: [
                            Icon(Icons.eco, color: Colors.white, size: 28),
                            SizedBox(width: 8), // Remove redundant const
                            Text("FarmerChat", style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
                          ],
                        ),
                        const Spacer(),
                        RichText(
                          text: const TextSpan(
                            style: TextStyle(fontSize: 45, fontWeight: FontWeight.bold, height: 1.1),
                            children: [
                              TextSpan(text: "Your\nFarm, ", style: TextStyle(color: Colors.white)),
                              TextSpan(text: "Your\nCommunity", style: TextStyle(color: Color(0xFFC7A16F))),
                            ],
                          ),
                        ),
                        const SizedBox(height: 40),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // --- BOTTOM SECTION (Cream Background) ---
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(35),
            decoration: const BoxDecoration(
              color: Color(0xFFFBF7EE),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(35),
                topRight: Radius.circular(35),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Join thousands of farmers sharing knowledge, prices, and support.",
                  style: TextStyle(color: Colors.black54, fontSize: 16),
                ),
                const SizedBox(height: 25),
                const SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      // Added 'const' to clean up blue lines
                       TagWidget(Icons.trending_up, "Market Prices"),
                       SizedBox(width: 10),
                       TagWidget(Icons.group, "Community"),
                       SizedBox(width: 10),
                       TagWidget(Icons.psychology, "Expert Advice"),
                    ],
                  ),
                ),
                const SizedBox(height: 35),

                // CREATE ACCOUNT BUTTON
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2D6A4F),
                    minimumSize: const Size(double.infinity, 60),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const CreateAccountScreen()),
                    );
                  },
                  child: const Text("Create Account", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                ),
                const SizedBox(height: 15),

                // LOGIN BUTTON
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Color(0xFF2D6A4F), width: 1.5),
                    minimumSize: const Size(double.infinity, 60),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  ),
                  onPressed: () {
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const DashboardScreen()));
                  },
                  child: const Text("I Already Have an Account", style: TextStyle(color: Color(0xFF2D6A4F), fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Pehle '_tag' tha, ab 'TagWidget' (Capital 'T' aur 'W')
class TagWidget extends StatelessWidget {
  final IconData icon;
  final String text;

  // Constructor ka naam bhi badal dein
  const TagWidget(this.icon, this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.black.withValues(alpha: 0.05)),
      ),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFFC7A16F), size: 16),
          const SizedBox(width: 6),
          Text(text, style: const TextStyle(fontSize: 13, color: Colors.black87)),
        ],
      ),
    );
  }
}