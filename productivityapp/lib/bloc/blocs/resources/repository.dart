import 'dart:async';
import 'api.dart';
import 'package:productivityapp/models/classes/user.dart';

class Repository {
  final apiProvider = ApiProvider();

  Future<User> registerUser(String username, String firstname, String lastname,
          String emailaddress, String password) =>
      apiProvider.registerUser(
          username, firstname, lastname, emailaddress, password);

  Future signinUser(String username, String password, String apiKey) =>
      apiProvider.signinUser(username, password, apiKey);

  Future getUserTasks(String apiKey) => apiProvider.getUserTasks(apiKey);
}
