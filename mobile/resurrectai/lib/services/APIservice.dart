import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String apiUrl;

  ApiService(this.apiUrl);

  Future<String> predict(String inputText) async {
    final response = await http.post(
      Uri.parse('$apiUrl/api'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({'input': inputText}),
    );

    if (response.statusCode == 200) {
      print(jsonDecode(response.body)['output']);
      return jsonDecode(response.body)['output'];
    } else {
      throw Exception('Failed to load prediction');
    }
  }
}
