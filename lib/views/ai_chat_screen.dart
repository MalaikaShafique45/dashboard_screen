import 'package:flutter/material.dart';
import '../../utility/app_constants.dart'; // Aapki constants file ka link

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
    // Check karein ke key 'welcome' hi ho (small w)
    var t = translations[selectedLanguage]!;

    return Scaffold(
      backgroundColor: const Color(0xFFF0F2F5),
      appBar: AppBar(
        title: const Text("Agri Dost AI",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
        backgroundColor: AppConstants.primaryGreen, // Hex color constants se aa raha hai
        elevation: 2,
        actions: [
          _buildLanguageButton('English'),
          _buildLanguageButton('سنڌي'),
          _buildLanguageButton('اردو'),
          const SizedBox(width: 5),
        ],
      ),
      body: Column(
        children: [
          // Chat Area
          Expanded(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  t['welcome']!, // Capital 'W' ko small 'w' kar diya
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 16, color: Colors.grey, fontWeight: FontWeight.w500),
                ),
              ),
            ),
          ),

          // Input Area
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, -2))
              ],
            ),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.camera_alt_outlined, color: AppConstants.secondaryGreen),
                  onPressed: () {},
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFF0F2F5),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: TextField(
                      controller: _controller,
                      // Language ke mutabiq alignment
                      textAlign: selectedLanguage == 'English' ? TextAlign.left : TextAlign.right,
                      decoration: InputDecoration(
                        hintText: t['hint'],
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.mic_none_outlined, color: AppConstants.secondaryGreen),
                  onPressed: () {},
                ),
                const SizedBox(width: 5),
                CircleAvatar(
                  backgroundColor: AppConstants.primaryGreen,
                  radius: 22,
                  child: IconButton(
                    icon: const Icon(Icons.send, color: Colors.white, size: 20),
                    onPressed: () {
                      if(_controller.text.isNotEmpty) {
                        _controller.clear();
                        // Yahan message send karne ki logic aayegi
                      }
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

  Widget _buildLanguageButton(String lang) {
    bool isSelected = selectedLanguage == lang;
    return GestureDetector(
      onTap: () => setState(() => selectedLanguage = lang),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 12),
        padding: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white24 : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            lang,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.white70,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              fontSize: 11,
            ),
          ),
        ),
      ),
    );
  }
}