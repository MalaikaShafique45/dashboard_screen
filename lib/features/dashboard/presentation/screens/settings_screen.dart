import 'package:flutter/material.dart';
import 'package:dashboard_screen/views/sign_in_screen.dart';
class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  // States
  bool isDarkMode = false;
  bool isOfflineMode = false;
  bool isLocationEnabled = true;
  bool isPasswordSaved = true;
  bool showActivityStatus = true; // New State
  bool weatherAlerts = true;

  static const Color primaryGreen = Color(0xFF1B4332);
  static const Color bgCream = Color(0xFFF9F3E5);

  @override
  Widget build(BuildContext context) {
    Color currentBg = isDarkMode ? Colors.black87 : bgCream;
    Color textColor = isDarkMode ? Colors.white : Colors.black87;

    return Scaffold(
      backgroundColor: currentBg,
      appBar: AppBar(
        title: const Text("Settings (ترتیبات)",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: primaryGreen,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: ListView(
        children: <Widget>[
          // --- Section 1: Preferences ---
          _sectionHeader("Preferences (ترجیحات)", textColor),

          _settingsTile(Icons.language, "App Language", "ایپ کی زبان (English / Urdu)", textColor, () {
            _showLanguageDialog(context);
          }),


          _switchTile(Icons.cloud_off_outlined, "Offline Mode", "انٹرنیٹ کے بغیر استعمال کریں", isOfflineMode, textColor, (bool value) {
            setState(() => isOfflineMode = value);
          }),

          const Divider(),

          // --- Section 2: Farm's Location & Privacy ---
          _sectionHeader("Farm's Location (کھیت کا مقام)", textColor),

          _switchTile(Icons.location_on_outlined, "Location Access", "کھیت کے مقام کی رسائی", isLocationEnabled, textColor, (bool value) {
            setState(() => isLocationEnabled = value);
          }),

          _switchTile(Icons.circle, "Activity Status", "آن لائن ہونے کی معلومات", showActivityStatus, textColor, (bool value) {
            setState(() => showActivityStatus = value);
          }),

          const Divider(),

          // --- Section 3: Security & Notifications ---
          _sectionHeader("Security & Notifications (حفاظت)", textColor),

          _switchTile(Icons.lock_outline, "Save Password", "لاگ ان کی معلومات محفوظ کریں", isPasswordSaved, textColor, (bool value) {
            setState(() => isPasswordSaved = value);
          }),

          _switchTile(Icons.wb_sunny_outlined, "Weather Alerts", "موسم کی اطلاع", weatherAlerts, textColor, (bool value) {
            setState(() => weatherAlerts = value);
          }),

          const Divider(),

          // --- Section 4: Support ---
          _sectionHeader("Support & Legal", textColor),



          _settingsTile(Icons.security, "Privacy Policy", "رازداری کی پالیسی", textColor, () {
            _showPolicyDialog(context);
          }),

          const SizedBox(height: 30),
          _logoutButton(),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  // --- Updated Language Dialog (Only English & Urdu) ---
  void _showLanguageDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        title: const Text("Select Language", textAlign: TextAlign.center),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
                leading: const Icon(Icons.language, color: primaryGreen),
                title: const Text("English"),
                onTap: () => Navigator.pop(context)
            ),
            ListTile(
                leading: const Icon(Icons.translate, color: primaryGreen),
                title: const Text("اردو (Urdu)"),
                onTap: () => Navigator.pop(context)
            ),
          ],
        ),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text("Confirm Logout", textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red)),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Are you sure you want to logout?"),
            SizedBox(height: 8),
            Text("کیا آپ واقعی لاگ آؤٹ کرنا چاہتے ہیں؟", style: TextStyle(fontWeight: FontWeight.w500)),
          ],
        ),
        actionsAlignment: MainAxisAlignment.spaceEvenly,
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context), // Dialog band karne ke liye
            child: const Text("Cancel (کینسل)", style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold)),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context, rootNavigator: true).pop();
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const SignInScreen()),
                    (route) => false,
              );
              print("Logout button clicked and navigating to Sign In...");
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
            child: const Text("Yes (جی ہاں)", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  // --- UI Helpers ---

  Widget _sectionHeader(String title, Color tColor) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Text(title, style: TextStyle(color: isDarkMode ? Colors.greenAccent : primaryGreen, fontWeight: FontWeight.bold, fontSize: 13)),
    );
  }

  Widget _settingsTile(IconData icon, String title, String subtitle, Color tColor, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: primaryGreen),
      title: Text(title, style: TextStyle(fontWeight: FontWeight.w600, color: tColor)),
      subtitle: Text(subtitle, style: TextStyle(fontSize: 12, color: tColor.withOpacity(0.7))),
      trailing: const Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey),
      onTap: onTap,
    );
  }

  Widget _switchTile(IconData icon, String title, String subtitle, bool val, Color tColor, Function(bool) onChanged) {
    return SwitchListTile(
      secondary: Icon(icon, color: primaryGreen),
      title: Text(title, style: TextStyle(fontWeight: FontWeight.w600, color: tColor)),
      subtitle: Text(subtitle, style: TextStyle(fontSize: 12, color: tColor.withOpacity(0.7))),
      activeColor: primaryGreen,
      value: val,
      onChanged: onChanged,
    );
  }

  Widget _logoutButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: OutlinedButton.icon(
        style: OutlinedButton.styleFrom(
            side: const BorderSide(color: Colors.red),
            foregroundColor: Colors.red,
            padding: const EdgeInsets.symmetric(vertical: 12),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))
        ),
        icon: const Icon(Icons.logout),
        onPressed: () => _showLogoutDialog(context),
        label: const Text("Logout (لاگ آؤٹ)", style: TextStyle(fontWeight: FontWeight.bold)),
      ),
    );
  }

  void _showSnackBar(BuildContext context, String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg), behavior: SnackBarBehavior.floating));
  }

  void _showPolicyDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        title: const Text("Privacy Policy"),
        content: const Text("محترم کسان! آپ کا ڈیٹا اس ایپ میں مکمل طور پر محفوظ ہے۔", textAlign: TextAlign.right),
        actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text("Close"))],
      ),
    );
  }
}