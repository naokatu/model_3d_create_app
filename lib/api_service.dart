import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiService {
  static Future<String> createModel({
    required String filename,
    required Map<String, double> dimensions,
  }) async {
    final apiUrl = dotenv.get('API_URL');
    final url = Uri.parse(apiUrl);

    try {
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'width': dimensions['width'],
          'length': dimensions['length'],
          'height': dimensions['height'],
          'filename': filename,
        }),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        return responseData['url'] ?? '';
      } else {
        print('Failed Request: ${response.statusCode}');
        return '';
      }
    } catch (e) {
      print('Error occur: $e');
      return '';
    }
  }
}