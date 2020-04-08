import 'dart:async';
import 'package:http/http.dart' show Client;
import 'dart:convert';
import 'package:productivityapp/models/classes/user.dart';

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
    print(response.body.toString());
    if (response.statusCode == 201) {
      // If the call to the server was successful, parse the JSON
      return User.fromJson(json.decode(response.body));
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }
}
