

import 'dart:convert';

import 'package:testgithub/model/ContributorsModel.dart';
import 'package:http/http.dart' as http;
import 'package:testgithub/response/ContributorResponse.dart';

abstract class ContributorRepository{
  Future<List<ContributorsModel>> getContributorsList();
}

class ContributorRepositoryImpl implements ContributorRepository {

  @override
  Future<List<ContributorsModel>> getContributorsList() async {
    var response = await http.get(
      Uri.parse("https://api.github.com/repos/square/retrofit/contributors"),
      headers: {
        "Content-Type": "application/json",
      },

    );
    print("response " + response.body.toString());
    if (response.statusCode == 200) {
      // var data = json.decode(response.body);
      var tagsJson = jsonDecode(response.body);
      List<dynamic> tags = tagsJson != null ? List.from(tagsJson) : null;
      ContributorsResponse responsec = ContributorsResponse(tags);
      return responsec.data;
    } else {
      throw Exception();
      // var data = json.decode(response.body);
      // EventSaveResponse eventSaveResponse = EventSaveResponse.fromJson(data);
      // return eventSaveResponse;
    }
  }
}