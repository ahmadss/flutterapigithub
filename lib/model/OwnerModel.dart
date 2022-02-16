

class OwnerModel{
  String _login;

  OwnerModel(parseJson){
    _login = parseJson['login'];

  }

  String get login => _login;

  set login(String value) {
    _login = value;
  }
}