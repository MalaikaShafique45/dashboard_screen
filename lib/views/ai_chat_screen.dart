import 'package:flutter/material.dart';

class AiChatScreen extends StatefulWidget {
  const AiChatScreen({super.key});

  @override
  State<AiChatScreen> createState() => _AiChatScreenState();
}

class _AiChatScreenState extends State<AiChatScreen> {
  String selectedLanguage = 'اردو';
  final TextEditingController _controller = TextEditingController();

  final Map<String, Map<String, String>> translations = {
    'English': {'welcome': 'Hello! How can I help you?', 'hint': 'Type message...'},
    'اردو': {'welcome': 'السلام علیکم! میں آپ کی کیا مدد کر سکتا ہوں؟', 'hint': 'پیغام لکھیں...'},
    'سنڌي': {'welcome': 'اسلام عليڪم! مان توهان جي ڪهڙي مدد ڪري سگهان ٿو؟', 'hint': 'پيغام لکو...'}
  };

  @override
  Widget build(BuildContext context) {
    var t = translations[selectedLanguage]!;
    const primaryGreen = Color(0xFF1B4332);

    return Scaffold(
      backgroundColor: const Color(0xFFF0F2F5),
      appBar: AppBar(
        title: const Text("Agri Dost AI", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: primaryGreen,
        elevation: 0,
        // Language Switcher in AppBar
        actions: [
          _buildLanguageButton('English'),
          _buildLanguageButton('سنڌي'),
          _buildLanguageButton('اردو'),
          const SizedBox(width: 5),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Text(t['welcome']!, style: const TextStyle(fontSize: 16, color: Colors.grey)),
            ),
          ),

          // --- FINAL CLEAN INPUT AREA ---
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
            color: Colors.white,
            child: Row(
              children: [
                // 1. Camera Button
                IconButton(
                  icon: const Icon(Icons.camera_alt_outlined, color: Colors.grey),
                  onPressed: () {}, // Camera Logic
                ),

                // 2. Text Input Area
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFF0F2F5),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: TextField(
                      controller: _controller,
                      textAlign: selectedLanguage == 'English' ? TextAlign.left : TextAlign.right,
                      // System Toolbar ko minimize karne ke liye properties
                      autocorrect: false,
                      enableSuggestions: false,
                      keyboardType: TextInputType.visiblePassword,
                      decoration: InputDecoration(
                        hintText: t['hint'],
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(horizontal: 15),
                      ),
                    ),
                  ),
                ),

                // 3. Speaker (Mic) Button
                IconButton(
                  icon: const Icon(Icons.mic_none_outlined, color: Colors.grey),
                  onPressed: () {}, // Voice Logic
                ),

                // 4. Send Button
                CircleAvatar(
                  backgroundColor: primaryGreen,
                  radius: 22,
                  child: IconButton(
                    icon: const Icon(Icons.send, color: Colors.white, size: 20),
                    onPressed: () {
                      _controller.clear();
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Helper widget for Top Language Buttons
  Widget _buildLanguageButton(String lang) {
    bool isSelected = selectedLanguage == lang;
    return TextButton(
      onPressed: () => setState(() => selectedLanguage = lang),
      child: Text(
        lang,
        style: TextStyle(
          color: isSelected ? Colors.white : Colors.white60,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          fontSize: 12,
        ),
      ),
    );
  }
}