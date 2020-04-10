import 'dart:async';
import 'package:http/http.dart' show Client;
import 'dart:convert';
import 'package:productivityapp/models/classes/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiProvider {
  Client client = Client();
  final _apiKey = '';

  Future<User> signinUser(
      String username, String password, String apiKey) async {
    final response = await client.post("http://127.0.0.1:5000/api/signin",
        headers: {'Authorization': apiKey},
        body: jsonEncode({"username": username, "password": password}));
    final Map result = json.decode(response.body);
    if (response.statusCode == 201) {
      await saveApiKey(result['data']['api_key']);
    } else {
      throw Exception('Failed to load post');
    }
  }

  Future<User> registerUser(String username, String firstname, String lastname,
      String emailaddress, String password) async {
    final response = await client.post("http://127.0.0.1:5000/api/register",
        body: jsonEncode({
          "username": username,
          "firstname": firstname,
          "lastname": lastname,
          "emailaddress": emailaddress,
          "password": password
        }));
    final Map result = json.decode(response.body);
    if (response.statusCode == 201) {
      await saveApiKey(result['data']['api_key']);
      return User.fromJson(result['data']);
    } else {
      throw Exception('Failed to load post');
    }
  }

  saveApiKey(String api_key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('API_Token', api_key);
  }
}
