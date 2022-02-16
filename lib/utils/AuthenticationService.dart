
import 'package:testgithub/model/ContributorsModel.dart';

abstract class AuthenticationService {
  Future<ContributorsModel> getContributor();
}

class FakeAuthenticationService extends AuthenticationService {
  @override
  Future<ContributorsModel> getContributor() async {
    return new ContributorsModel(null); // return null for now
  }

}
