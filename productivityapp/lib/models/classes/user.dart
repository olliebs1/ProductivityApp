class User {
  String username;
  String firstname;
  String lastname;
  String emailaddress;
  String password;
  String id;
  String api_key;

  User(this.username, this.firstname, this.lastname, this.emailaddress,
      this.password, this.id, this.api_key);

  User.fromJson(Map<String, dynamic> parsedJson) {
    User user = new User(
      parsedJson['username'],
      parsedJson['firstname'],
      parsedJson['lastname'],
      parsedJson['emailaddress'],
      parsedJson['password'],
      parsedJson['id'],
      parsedJson['api_key '],
    );
  }
}
