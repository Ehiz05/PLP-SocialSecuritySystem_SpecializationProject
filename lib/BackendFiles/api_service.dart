import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = "http://127.0.0.1:5000";

  Future<Map<String, dynamic>> makePayment(String token, int userId, double amount, String description) async {
    final response = await http.post(
      Uri.parse("$baseUrl/make-payment"),
      headers: {"Content-Type": "application/json"},
      body: json.encode({
        "token": token,
        "user_id": userId,
        "amount": amount,
        "description": description,
      }),
    );
    return json.decode(response.body);
  }

  Future<Map<String, dynamic>> getTransactions(int userId) async {
    final response = await http.get(Uri.parse("$baseUrl/transactions/$userId"));
    return json.decode(response.body);
  }
}
