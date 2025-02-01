import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = "http://10.0.2.2/flutter_php";

  // Fetch Notes
  static Future<List<dynamic>> getNotes() async {
    final response = await http.get(Uri.parse("$baseUrl/get_notes.php"));
    return jsonDecode(response.body);
  }

  // Add Note
  static Future<bool> addNote(String title, String description) async {
    final response = await http.post(
      Uri.parse("$baseUrl/add_note.php"),
      body: {"title": title, "description": description},
    );

    log("🔹 Response Status: ${response.statusCode}");
    log("🔹 Response Body: ${response.body}");

    return response.statusCode == 200 && response.body.contains("success");
  }

  // Update Note
  static Future<bool> updateNote(
      int id, String title, String description) async {
    final response = await http.post(
      Uri.parse("$baseUrl/update_note.php"),
      body: {"id": id.toString(), "title": title, "description": description},
    );
    return response.statusCode == 200;
  }

  // Delete Note
  static Future<bool> deleteNote(int id) async {
    final response = await http.post(
      Uri.parse("$baseUrl/delete_note.php"),
      body: {"id": id.toString()},
    );
    return response.statusCode == 200;
  }
}
