import '../blocs/resources/repository.dart';
import 'package:rxdart/rxdart.dart';
import 'package:productivityapp/models/classes/user.dart';

class UserBloc {
  final _repository = Repository();
  final _userGetter = PublishSubject<User>();

  Observable<User> get getUser => _userGetter.stream;

  registerUser(String username, String firstname, String lastname,
      String emailaddress, String password) async {
    User user = await _repository.registerUser(
        username, firstname, lastname, emailaddress, password);
    _userGetter.sink.add(user);
  }

  dispose() {
    _userGetter.close();
  }
}

final bloc = UserBloc();