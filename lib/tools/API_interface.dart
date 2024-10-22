import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiInterface {
  static Future<void> sendTestRequest(
      String userID, String title, String textBody) async {
    try {
      // Define the URI
      Uri uri = Uri.parse('http://161.35.68.157/notify');

      // Define the body exactly as expected by the server
      String body = jsonEncode({
        "targetUserID": userID,
        "messageTitle": title,
        "messageBody": textBody
      });

      // Send the POST request
      var response = await http.post(
        uri,
        headers: {
          'Content-Type': 'application/json',
        },
        body: body, // JSON-encoded body string
      );

      // Print the response status and body for debugging
      print("Status Code: ${response.statusCode}");
      print("Response Body: ${response.body}");
    } catch (e) {
      print("Error occurred: $e");
    }
  }
  
}
