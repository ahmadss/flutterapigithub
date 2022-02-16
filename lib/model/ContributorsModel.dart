

class ContributorsModel{
  String _login;
  int _id;
  String _node_id;
  String _avatar_url;
  String _url;
  String _type;

  ContributorsModel(parseJson){
    _login = parseJson['login'];
    _id = parseJson['id'];
    _node_id = parseJson['node_id'];
    _avatar_url = parseJson['avatar_url'];
    _url = parseJson['url'];
    _type = parseJson['type'];

  }


  String get type => _type;

  set type(String value) {
    _type = value;
  }

  String get url => _url;

  set url(String value) {
    _url = value;
  }

  String get avatar_url => _avatar_url;

  set avatar_url(String value) {
    _avatar_url = value;
  }

  String get node_id => _node_id;

  set node_id(String value) {
    _node_id = value;
  }

  int get id => _id;

  set id(int value) {
    _id = value;
  }

  String get login => _login;

  set login(String value) {
    _login = value;
  }
}