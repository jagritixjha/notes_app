import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class ApiService {
  // static const String baseUrl = "http://10.0.2.2/flutter_php";
  static String get baseUrl {
    if (kIsWeb) {
      return "http://localhost/flutter_php";
    } else if (Platform.isAndroid) {
      return "http://10.0.2.2/flutter_php";
    } else if (Platform.isIOS) {
      return "http://127.0.0.1/flutter_php";
    } else {
      return "http://192.168.138.12/flutter_php";
    }
  }

  // Fetch Notes
  static Future<List<dynamic>> getNotes() async {
    final response = await http.get(Uri.parse("$baseUrl/get_notes.php"));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      log('nothing in the list');
      return [];
    }
  }

  // Add Note
  static Future<bool> addNote(String title, String description) async {
    try {
      final response = await http.post(
        Uri.parse("$baseUrl/add_note.php"),
        body: {"title": title, "description": description},
      );

      log("🔹 Response Status: ${response.statusCode}");
      log("🔹 Response Body: ${response.body}");

      return response.statusCode == 200 && response.body.contains("success");
    } catch (e) {
      log('-----------failed');
      return false;
    }
  }

  // Update Note
  static Future<bool> updateNote(
      String id, String title, String description) async {
    final response = await http.post(
      Uri.parse("$baseUrl/update_note.php"),
      body: {"id": id, "title": title, "description": description},
    );
    return response.statusCode == 200;
  }

  // Delete Note
  static Future<bool> deleteNote(String id) async {
    final response = await http.post(
      Uri.parse("$baseUrl/delete_note.php"),
      body: {"id": id},
    );
    return response.statusCode == 200;
  }
}
