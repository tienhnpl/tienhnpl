import 'package:http/http.dart' as http;
import '../models/place_model.dart';
import 'dart:developer'; // Import thư viện developer

class ApiService {
  final String apiUrl = "http://10.0.2.2:1337/api/places?populate=*";

  Future<List<Place>?> getAllPlace() async {
    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {

        // --- BƯỚC DEBUG: IN DỮ LIỆU RAW RA CONSOLE ---
        log("===== RAW JSON RESPONSE FROM STRAPI =====");
        log(response.body); // Sử dụng log() để tránh bị cắt bớt nội dung dài
        log("========================================");
        // --- KẾT THÚC BƯỚC DEBUG ---

        List<Place> places = placeFromJson(response.body);
        return places;
      } else {
        print("Failed to load data. Status code: ${response.statusCode}");
        print("Response body: ${response.body}");
      }
    } catch (e) {
      print("An error occurred in ApiService: ${e.toString()}");
    }
    return null;
  }
}