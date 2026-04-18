import 'package:flutter/material.dart';

class AiChatScreen extends StatefulWidget {
  const AiChatScreen({super.key});

  @override
  State<AiChatScreen> createState() => _AiChatScreenState();
}

class _AiChatScreenState extends State<AiChatScreen> {
  // Current Selected Language
  String selectedLanguage = 'اردو';

  final TextEditingController _controller = TextEditingController();

  // Translation Maps
  final Map<String, Map<String, String>> translations = {
    'English': {
      'welcome': 'Hello! I am your AI Agriculture Advisor. Ask me anything about crops, fertilizers, or weather.',
      'hint': 'Write your question here...',
      'q1': 'Treatment for tomato diseases?',
      'q2': 'Which fertilizer for wheat?',
      'q3': 'Best time to sow cotton?',
      'q4': 'How to save crops from water shortage?',
    },
    'اردو': {
      'welcome': 'السلام علیکم! میں آپ کا زرعی مشیر ہوں۔ فصلوں، کھاد، موسم یا کسی بھی زرعی مسئلے کے بارے میں پوچھیں۔',
      'hint': 'اپنا سوال یہاں لکھیں۔۔۔',
      'q1': 'ٹماٹر کی بیماریوں کا علاج بتائیں؟',
      'q2': 'گندم کی فصل میں کونسی کھاد استعمال کروں؟',
      'q3': 'کپاس کی کاشت کا بہترین وقت کیا ہے؟',
      'q4': 'پانی کی کمی میں فصل کیسے بچائیں؟',
    },
    'سنڌي': {
      'welcome': 'اسلام عليڪم! مان توهان جو زرعي صلاحڪار آهيان. فصلن، ڀاڻ، موسم يا ڪنهن به زرعي مسئلي بابت پڇو.',
      'hint': 'پنهنجو سوال هتي لکو۔۔۔',
      'q1': 'ٽماٽي جي بيمارين جو علاج ٻڌايو؟',
      'q2': 'ڪڻڪ جي فصل ۾ ڪهڙو ڀاڻ استعمال ڪجي؟',
      'q3': 'ڦٽيءَ جي پوکيءَ جو بهترين وقت ڪهڙو آهي؟',
      'q4': 'پاڻيءَ جي کوٽ ۾ فصل ڪيئن بچائجي؟',
    }
  };

  @override
  Widget build(BuildContext context) {
    var t = translations[selectedLanguage]!;

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAF8),
      appBar: AppBar(
        title: const Text("Farmer Chat | کسان چیٹ"),
        backgroundColor: const Color(0xFF1B4332),
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          // 1. Language Selection Header
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: ['English', 'سنڌي', 'اردو'].map((lang) {
                bool isSelected = selectedLanguage == lang;
                return GestureDetector(
                  onTap: () => setState(() => selectedLanguage = lang),
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                    decoration: BoxDecoration(
                      color: isSelected ? const Color(0xFF2D6A4F) : Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: Text(
                      lang,
                      style: TextStyle(
                        color: isSelected ? Colors.white : Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),

          // 2. Chat Area
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 40),
                  const Icon(Icons.eco, color: Color(0xFF52B788), size: 60),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Text(
                      t['welcome']!,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                  ),
                  const SizedBox(height: 30),

                  // 3. Quick Question Chips
                  _buildQuickQuestions(t),
                ],
              ),
            ),
          ),

          // 4. Input Area
          _buildInputSection(t),
        ],
      ),
    );
  }

  Widget _buildQuickQuestions(Map<String, String> t) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Wrap(
        spacing: 10,
        runSpacing: 10,
        children: [t['q1']!, t['q2']!, t['q3']!, t['q4']!].map((ques) {
          return ActionChip(
            label: Text(ques),
            backgroundColor: Colors.white,
            onPressed: () => _controller.text = ques,
          );
        }).toList(),
      ),
    );
  }

  Widget _buildInputSection(Map<String, String> t) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: const BoxDecoration(color: Colors.white),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              textAlign: selectedLanguage == 'English' ? TextAlign.left : TextAlign.right,
              decoration: InputDecoration(
                hintText: t['hint'],
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                contentPadding: const EdgeInsets.symmetric(horizontal: 15),
              ),
            ),
          ),
          const SizedBox(width: 10),
          CircleAvatar(
            backgroundColor: const Color(0xFF52B788),
            child: IconButton(
              icon: const Icon(Icons.send, color: Colors.white),
              onPressed: () {
                // Logic for sending message
                _controller.clear();
              },
            ),
          )
        ],
      ),
    );
  }
}