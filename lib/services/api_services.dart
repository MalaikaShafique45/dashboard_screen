import 'dart:convert';
import 'package:http/http.dart' as http;
// Is line ko check karein ke aapka project name 'dashboard_screen' hi hai na?
import 'package:dashboard_screen/models/market_rate_model.dart';

class ApiService {
  static const String baseUrl = "http://10.0.2.2:8000/api";

  // Future ke sath <MarketRateModel> likhna zaroori hai
  Future<List<MarketRateModel>> fetchMarketRates() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/market-rates/'));

      if (response.statusCode == 200) {
        final List<dynamic> body = jsonDecode(response.body);

        // Yahan mapping check karein
        return body.map((item) => MarketRateModel.fromJson(item)).toList();
      } else {
        throw Exception('Server error: ${response.statusCode}');
      }
    } catch (e) {
      // Agar error ho toh khali list return karein jo MarketRateModel type ki ho
      return <MarketRateModel>[];
    }
  }
}