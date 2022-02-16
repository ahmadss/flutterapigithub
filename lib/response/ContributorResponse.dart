
import 'package:testgithub/model/ContributorsModel.dart';

class ContributorsResponse {
  List<ContributorsModel> _data = [];

  ContributorsResponse(List<dynamic> parsedJson) {
    for (int i = 0; i < parsedJson.length; i++) {
       ContributorsModel model = ContributorsModel(parsedJson[i]);
      _data.add(model);
    }
  }

  List<ContributorsModel> get data => _data;

  set data(List<ContributorsModel> value) {
    _data = value;
  }


}