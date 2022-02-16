import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:testgithub/model/ContributorsModel.dart';

@immutable
abstract class BottomNavigationState extends Equatable {
  BottomNavigationState([List props = const []]);
}

class CurrentIndexChanged extends BottomNavigationState {
  final int currentIndex;

  CurrentIndexChanged({@required this.currentIndex});

  @override
  String toString() => 'CurrentIndexChanged to $currentIndex';

  @override
  List<Object> get props => [];
}

class PageLoading extends BottomNavigationState {
  @override
  String toString() => 'PageLoading';

  @override
  List<Object> get props => [];
}

class ContributorsPageLoaded extends BottomNavigationState {
  final List<ContributorsModel> list;
  ContributorsPageLoaded(@required this.list) : super([list]);

  @override
  List<Object> get props => [];
}



class RepositoriesPageLoaded extends BottomNavigationState {
  final String strData;
  RepositoriesPageLoaded(@required this.strData) : super([strData]);


  @override
  List<Object> get props => [];
}
