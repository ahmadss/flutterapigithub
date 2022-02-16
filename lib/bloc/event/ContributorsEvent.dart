

import 'package:equatable/equatable.dart';

abstract class ContributorsEvent extends Equatable{

}

class FetchContributorsEvent extends ContributorsEvent{
  @override
  List<Object> get props => [];
}
