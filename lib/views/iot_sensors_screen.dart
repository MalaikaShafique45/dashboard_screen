import 'package:flutter/material.dart';

class IotSensorsScreen extends StatelessWidget {
  const IotSensorsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        title: const Text("Smart Farm (IoT)",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFF1B4332),
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Smart Farm (IoT)", // Updated Name
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const Text(
                "سمارٹ فارم (آئی او ٹی)", // Updated Urdu Name
                style: TextStyle(color: Colors.grey, fontSize: 16)
            ),
            const SizedBox(height: 20),

            // 1. Soil Moisture Card
            _sensorChartCard(
              title: "Soil Moisture Sensor",
              urduTitle: "زمین کی نمی سینسر",
              value: "52%",
              color: Colors.blue,
              status: "Normal",
            ),

            const SizedBox(height: 20),

            // 2. Temperature & Humidity Card
            _sensorChartCard(
              title: "Temperature & Humidity",
              urduTitle: "درجہ حرارت اور نمی",
              value: "34°C",
              color: Colors.orange,
              status: "Normal",
              extraValue: "Humidity: 59%",
            ),

            const SizedBox(height: 25),

            // 3. Advice Section Header
            const Row(
              children: [
                Text("Smart Advice ", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                Text("(مشورہ)", style: TextStyle(fontSize: 16, color: Colors.grey)),
              ],
            ),
            const SizedBox(height: 15),

            _adviceCard(
                "Irrigation Advice",
                "Consider irrigating your field soon.",
                "جلد اپنے کھیت کو پانی دیں۔",
                Icons.water_drop
            ),
            _adviceCard(
                "Temperature Advice",
                "Temperature is favorable for crops.",
                "درجہ حرارت فصلوں کے لیے مناسب ہے۔",
                Icons.thermostat
            ),
          ],
        ),
      ),
    );
  }

  // Sensor Card Helper
  Widget _sensorChartCard({
    required String title,
    required String urduTitle,
    required String value,
    required Color color,
    required String status,
    String? extraValue
  }) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(color: Colors.grey.withValues(alpha: 0.1)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    Text(urduTitle, style: const TextStyle(color: Colors.grey, fontSize: 12)),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                      color: const Color(0xFFD8F3DC),
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: Text(
                      status,
                      style: const TextStyle(color: Color(0xFF1B4332), fontSize: 12, fontWeight: FontWeight.bold)
                  ),
                )
              ],
            ),
            const SizedBox(height: 15),
            Text(value, style: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold)),
            if (extraValue != null)
              Text(extraValue, style: const TextStyle(color: Colors.blueGrey, fontSize: 14)),
            const SizedBox(height: 15),

            Container(
              height: 80,
              width: double.infinity,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Center(
                  child: Icon(Icons.show_chart, color: color, size: 40)
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Advice Card Helper
  Widget _adviceCard(String title, String eng, String urdu, IconData icon) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
        side: BorderSide(color: Colors.grey.withValues(alpha: 0.1)),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: CircleAvatar(
          backgroundColor: const Color(0xFFD8F3DC),
          child: Icon(icon, color: const Color(0xFF1B4332)),
        ),
        title: Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold)
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(eng, style: const TextStyle(fontSize: 13, color: Colors.black87)),
            Text(
                urdu,
                style: const TextStyle(fontSize: 12, color: Colors.grey, fontWeight: FontWeight.w500)
            ),
          ],
        ),
      ),
    );
  }
}