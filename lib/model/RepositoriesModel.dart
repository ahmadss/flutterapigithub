

import 'package:testgithub/model/OwnerModel.dart';

class RepositoriesModel{
  String _name;
  String _url;
  OwnerModel _owner;

  RepositoriesModel(parseJson){
    _name = parseJson['name'];
    _url = parseJson['url'];
    _owner = OwnerModel(parseJson['owner']);

  }

  OwnerModel get owner => _owner;

  set owner(OwnerModel value) {
    _owner = value;
  }

  String get url => _url;

  set url(String value) {
    _url = value;
  }

  String get name => _name;

  set name(String value) {
    _name = value;
  }
}