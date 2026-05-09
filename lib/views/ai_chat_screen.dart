import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../utility/app_constants.dart';

const String DJANGO_BASE_URL = 'http://192.168.1.9:8000';

class AiChatScreen extends StatefulWidget {
  const AiChatScreen({super.key});

  @override
  State<AiChatScreen> createState() => _AiChatScreenState();
}

class _AiChatScreenState extends State<AiChatScreen> {
  String selectedLanguage = 'اردو';
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  bool _isLoading = false;

  final List<Map<String, String>> _messages = [];

  final Map<String, Map<String, String>> translations = {
    'English': {
      'welcome': 'Hello! Ask me about crops, weather, or market prices.',
      'hint': 'Type message...',
      'error': 'Could not connect. Check your internet.',
      'thinking': 'Thinking...',
    },
    'اردو': {
      'welcome': 'السلام علیکم! فصل، موسم یا مارکیٹ قیمتوں کے بارے میں پوچھیں۔',
      'hint': 'پیغام لکھیں...',
      'error': 'کنکشن نہیں ہوا۔ انٹرنیٹ چیک کریں۔',
      'thinking': 'سوچ رہا ہوں...',
    },
    'سنڌي': {
      'welcome': 'اسلام عليڪم! فصل، موسم يا مارڪيٽ قيمتن بابت پڇو.',
      'hint': 'پيغام لکو...',
      'error': 'ڪنيڪشن نه ٿيو. انٽرنيٽ چيڪ ڪريو.',
      'thinking': 'سوچي رهيو آهيان...',
    },
  };

  Future<void> _sendMessage() async {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    setState(() {
      _messages.add({'role': 'user', 'text': text});
      _isLoading = true;
    });
    _controller.clear();
    _scrollToBottom();

    try {
      final response = await http.post(
        Uri.parse('$DJANGO_BASE_URL/api/chat/'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'message': text}),
      ).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final data = jsonDecode(utf8.decode(response.bodyBytes));
        final botReply = data['response'] ?? translations[selectedLanguage]!['error']!;
        setState(() {
          _messages.add({'role': 'bot', 'text': botReply});
          _isLoading = false;
        });
      } else {
        _addErrorMessage();
      }
    } catch (e) {
      _addErrorMessage();
    }

    _scrollToBottom();
  }

  void _addErrorMessage() {
    setState(() {
      _messages.add({'role': 'bot', 'text': translations[selectedLanguage]!['error']!});
      _isLoading = false;
    });
  }

  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  Widget _buildBubble(Map<String, String> msg) {
    final isUser = msg['role'] == 'user';
    final isRTL = selectedLanguage != 'English';

    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.75),
        decoration: BoxDecoration(
          color: isUser ? AppConstants.primaryGreen : Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(16),
            topRight: const Radius.circular(16),
            bottomLeft: Radius.circular(isUser ? 16 : 4),
            bottomRight: Radius.circular(isUser ? 4 : 16),
          ),
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4, offset: const Offset(0, 2))],
        ),
        child: Text(
          msg['text']!,
          textAlign: isRTL ? TextAlign.right : TextAlign.left,
          textDirection: isRTL ? TextDirection.rtl : TextDirection.ltr,
          style: TextStyle(color: isUser ? Colors.white : Colors.black87, fontSize: 14.5, height: 1.4),
        ),
      ),
    );
  }

  Widget _buildThinkingIndicator() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 16, height: 16,
              child: CircularProgressIndicator(strokeWidth: 2, color: AppConstants.primaryGreen),
            ),
            const SizedBox(width: 8),
            Text(translations[selectedLanguage]!['thinking']!, style: const TextStyle(color: Colors.grey, fontSize: 13)),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var t = translations[selectedLanguage]!;
    final isRTL = selectedLanguage != 'English';

    return Scaffold(
      backgroundColor: const Color(0xFFF0F2F5),
      appBar: AppBar(
        title: const Text("Agri Dost AI",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
        backgroundColor: AppConstants.primaryGreen,
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
          Expanded(
            child: _messages.isEmpty
                ? Center(
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.agriculture, size: 64, color: AppConstants.primaryGreen.withOpacity(0.4)),
                          const SizedBox(height: 16),
                          Text(t['welcome']!,
                              textAlign: TextAlign.center,
                              textDirection: isRTL ? TextDirection.rtl : TextDirection.ltr,
                              style: const TextStyle(fontSize: 15, color: Colors.grey, fontWeight: FontWeight.w500)),
                        ],
                      ),
                    ),
                  )
                : ListView.builder(
                    controller: _scrollController,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    itemCount: _messages.length + (_isLoading ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (index == _messages.length) return _buildThinkingIndicator();
                      return _buildBubble(_messages[index]);
                    },
                  ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
            decoration: const BoxDecoration(
              color: Colors.white,
              boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, -2))],
            ),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.camera_alt_outlined, color: AppConstants.secondaryGreen),
                  onPressed: () {},
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(color: const Color(0xFFF0F2F5), borderRadius: BorderRadius.circular(25)),
                    child: TextField(
                      controller: _controller,
                      textAlign: isRTL ? TextAlign.right : TextAlign.left,
                      textDirection: isRTL ? TextDirection.rtl : TextDirection.ltr,
                      onSubmitted: (_) => _sendMessage(),
                      decoration: InputDecoration(
                        hintText: t['hint'],
                        hintTextDirection: isRTL ? TextDirection.rtl : TextDirection.ltr,
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
                    onPressed: _isLoading ? null : _sendMessage,
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
          child: Text(lang,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.white70,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                fontSize: 11,
              )),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }
}
