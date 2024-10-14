import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String apiUrl;

  ApiService(this.apiUrl);

  Future<String> predict(
      String inputText, List<Map<String, String>> data) async {
    final response = await http.post(
      Uri.parse('https://amazingly-happy-hamster.ngrok-free.app/predict'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({'text': inputText, 'data': data}),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body)['Gandhi Ji'];
    } else {
      throw Exception('Failed to load prediction: ${response.body}');
    }
  }
}
