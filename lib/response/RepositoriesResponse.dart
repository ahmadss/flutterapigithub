import 'package:testgithub/model/RepositoriesModel.dart';

class RepositoriesResponse{
    List<RepositoriesModel> _contents = [];

    // RepositoriesResponse.fromJson(List<dynamic> parsedJson) {
    //     for(int i = 0; i < parsedJson.length;i++){
    //       RepositoriesModel Repositories = RepositoriesModel(parsedJson[i]);
    //       _contents.add(Repositories);
    //     }
    // }

    RepositoriesResponse.fromJson(Map<String, dynamic> parsedJson) {
          for(int i = 0; i < parsedJson['items'].length;i++){
            RepositoriesModel Repositories = RepositoriesModel(parsedJson['items'][i]);
            _contents.add(Repositories);
          }
      }


    List<RepositoriesModel> get contents => _contents;

  set contents(List<RepositoriesModel> value) {
    _contents = value;
  }
}