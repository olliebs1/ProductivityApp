import 'dart:async';
import 'api.dart';
import 'package:productivityapp/models/classes/user.dart';

class Repository {
  final apiProvider = ApiProvider();

  Future<User> registerUser(String username, String firstname, String lastname,
          String emailaddress, String password) =>
      apiProvider.registerUser(
          username, firstname, lastname, emailaddress, password);
}
