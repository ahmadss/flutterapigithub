import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:testgithub/model/RepositoriesModel.dart';
import 'package:testgithub/response/RepositoriesResponse.dart';

abstract class RepositoriesRepository{
  Future<List<RepositoriesModel>> getRepositoriesList(String searchQuery, int start, int limit);
}

class RepositoriesRepositoryImpl implements RepositoriesRepository{
  @override
  Future<List<RepositoriesModel>> getRepositoriesList(String searchQuery, int start, int limit) async{
    if(searchQuery.toString()==null || searchQuery.toString()==""){
      searchQuery = "flutter";
    }
    String url = "https://api.github.com/search/repositories?q="+searchQuery.toString()+"&page="+start.toString()+"&per_page="+limit.toString();
    print("url "+url);
    var response = await http.get(Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
        });
    print("response "+response.body.toString());
    if (response.statusCode == 200) {
      var tagsJson = jsonDecode(response.body);
      List<dynamic> tags = tagsJson != null ? List.from(tagsJson['items']) : null;
      List<RepositoriesModel> RepositoriesList = RepositoriesResponse.fromJson(tagsJson).contents;
      int count = RepositoriesList.length;
      print("count "+count.toString());
      return RepositoriesList;
    } else {
      throw Exception();
    }
  }

}