import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../utility/app_constants.dart';

// ─────────────────────────────────────────────
// IMPORTANT: Change this to your PC's IP address
// Find it by running: ipconfig  in PowerShell
// Use the IPv4 address, e.g. 192.168.1.5
// Do NOT use 127.0.0.1 — that won't work on phone
const String DJANGO_BASE_URL = 'http://192.168.1.5:8000';
// ─────────────────────────────────────────────

class ChatMessage {
  final String text;
  final bool isUser;
  final String language;

  ChatMessage({
    required this.text,
    required this.isUser,
    required this.language,
  });
}

class AiChatScreen extends StatefulWidget {
  const AiChatScreen({super.key});

  @override
  State<AiChatScreen> createState() => _AiChatScreenState();
}

class _AiChatScreenState extends State<AiChatScreen> {
  String selectedLanguage = 'اردو';
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final List<ChatMessage> _messages = [];
  bool _isLoading = false;

  final Map<String, Map<String, String>> translations = {
    'English': {
      'welcome': 'Hello! Ask me about crops, weather, or market prices.',
      'hint': 'Type message...',
      'error': 'Could not connect. Check your internet.',
      'thinking': 'Thinking...',
    },
    'اردو': {
      'welcome': 'السلام علیکم! فصل، موسم یا قیمتوں کے بارے میں پوچھیں۔',
      'hint': 'پیغام لکھیں...',
      'error': 'کنیکشن نہیں ہو سکا۔ انٹرنیٹ چیک کریں۔',
      'thinking': 'سوچ رہا ہوں...',
    },
    'سنڌي': {
      'welcome': 'اسلام عليڪم! فصل، موسم يا قيمتن بابت پڇو.',
      'hint': 'پيغام لکو...',
      'error': 'ڪنيڪشن نه ٿيو. انٽرنيٽ چيڪ ڪريو.',
      'thinking': 'سوچي رهيو آهيان...',
    },
  };

  @override
  void initState() {
    super.initState();
    // Show welcome message on start
    _addBotMessage(translations[selectedLanguage]!['welcome']!);
  }

  void _addBotMessage(String text) {
    setState(() {
      _messages.add(ChatMessage(
        text: text,
        isUser: false,
        language: selectedLanguage,
      ));
    });
    _scrollToBottom();
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

  Future<void> _sendMessage() async {
    final text = _controller.text.trim();
    if (text.isEmpty || _isLoading) return;

    // Add user message to chat
    setState(() {
      _messages.add(ChatMessage(text: text, isUser: true, language: selectedLanguage));
      _isLoading = true;
    });
    _controller.clear();
    _scrollToBottom();

    // Call Django chatbot API
    try {
      final response = await http.post(
        Uri.parse('$DJANGO_BASE_URL/api/chat/'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'message': text}),
      ).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final data = jsonDecode(utf8.decode(response.bodyBytes));
        final botReply = data['response'] ?? translations[selectedLanguage]!['error']!;
        _addBotMessage(botReply);
      } else {
        _addBotMessage(translations[selectedLanguage]!['error']!);
      }
    } catch (e) {
      _addBotMessage(translations[selectedLanguage]!['error']!);
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _onLanguageChange(String lang) {
    setState(() {
      selectedLanguage = lang;
      _messages.clear();
    });
    _addBotMessage(translations[lang]!['welcome']!);
  }

  @override
  Widget build(BuildContext context) {
    var t = translations[selectedLanguage]!;
    bool isRTL = selectedLanguage != 'English';

    return Scaffold(
      backgroundColor: const Color(0xFFF0F2F5),
      appBar: AppBar(
        title: const Text(
          "Agri Dost AI",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
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
          // ── Chat messages area ──────────────────────
          Expanded(
            child: _messages.isEmpty
                ? Center(
                    child: Text(
                      t['welcome']!,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  )
                : ListView.builder(
                    controller: _scrollController,
                    padding: const EdgeInsets.all(12),
                    itemCount: _messages.length + (_isLoading ? 1 : 0),
                    itemBuilder: (context, index) {
                      // Show typing indicator at end
                      if (_isLoading && index == _messages.length) {
                        return _buildTypingIndicator(t['thinking']!);
                      }
                      return _buildMessageBubble(_messages[index]);
                    },
                  ),
          ),

          // ── Input area ──────────────────────────────
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
            decoration: const BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 4,
                  offset: Offset(0, -2),
                )
              ],
            ),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.camera_alt_outlined,
                    color: AppConstants.secondaryGreen,
                  ),
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
                      textAlign: isRTL ? TextAlign.right : TextAlign.left,
                      textDirection: isRTL ? TextDirection.rtl : TextDirection.ltr,
                      onSubmitted: (_) => _sendMessage(),
                      decoration: InputDecoration(
                        hintText: t['hint'],
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 10,
                        ),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(
                    Icons.mic_none_outlined,
                    color: AppConstants.secondaryGreen,
                  ),
                  onPressed: () {},
                ),
                const SizedBox(width: 5),
                CircleAvatar(
                  backgroundColor: AppConstants.primaryGreen,
                  radius: 22,
                  child: IconButton(
                    icon: _isLoading
                        ? const SizedBox(
                            width: 18,
                            height: 18,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          )
                        : const Icon(Icons.send, color: Colors.white, size: 20),
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

  // ── Message bubble widget ───────────────────────────
  Widget _buildMessageBubble(ChatMessage message) {
    bool isRTL = message.language != 'English';
    bool isUser = message.isUser;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment:
            isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // Bot avatar
          if (!isUser) ...[
            CircleAvatar(
              radius: 16,
              backgroundColor: AppConstants.primaryGreen,
              child: const Icon(Icons.eco, color: Colors.white, size: 16),
            ),
            const SizedBox(width: 6),
          ],

          // Message bubble
          Flexible(
            child: Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.72,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: BoxDecoration(
                color: isUser
                    ? AppConstants.primaryGreen
                    : Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(18),
                  topRight: const Radius.circular(18),
                  bottomLeft: Radius.circular(isUser ? 18 : 4),
                  bottomRight: Radius.circular(isUser ? 4 : 18),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.06),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  )
                ],
              ),
              child: Text(
                message.text,
                textAlign: isRTL ? TextAlign.right : TextAlign.left,
                textDirection:
                    isRTL ? TextDirection.rtl : TextDirection.ltr,
                style: TextStyle(
                  color: isUser ? Colors.white : Colors.black87,
                  fontSize: 14.5,
                  height: 1.4,
                ),
              ),
            ),
          ),

          // User avatar
          if (isUser) ...[
            const SizedBox(width: 6),
            CircleAvatar(
              radius: 16,
              backgroundColor: Colors.grey.shade300,
              child: const Icon(Icons.person, color: Colors.grey, size: 16),
            ),
          ],
        ],
      ),
    );
  }

  // ── Typing indicator ────────────────────────────────
  Widget _buildTypingIndicator(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          CircleAvatar(
            radius: 16,
            backgroundColor: AppConstants.primaryGreen,
            child: const Icon(Icons.eco, color: Colors.white, size: 16),
          ),
          const SizedBox(width: 6),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
                const SizedBox(width: 8),
                Text(text, style: const TextStyle(color: Colors.grey)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ── Language button ─────────────────────────────────
  Widget _buildLanguageButton(String lang) {
    bool isSelected = selectedLanguage == lang;
    return GestureDetector(
      onTap: () => _onLanguageChange(lang),
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

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }
}
