import 'dart:async';
import 'package:http/http.dart' show Client;
import 'dart:convert';
import 'package:productivityapp/models/classes/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiProvider {
  Client client = Client();
  final _apiKey = '';

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
    print('saving1');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print('saving2');
    await prefs.setString('API_Token', api_key);
    print('saving3');
  }
}
