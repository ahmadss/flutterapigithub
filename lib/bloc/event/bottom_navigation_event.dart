import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class BottomNavigationEvent extends Equatable {
  BottomNavigationEvent([List props = const []]) : super();
}

class AppStarted extends BottomNavigationEvent {
  @override
  String toString() => 'AppStarted';

  @override
  List<Object> get props => [];
}

class AppContributors extends BottomNavigationEvent{
  @override
  String toString() => 'AppContributors';

  @override
  List<Object> get props => [];
}

class AppRepositories extends BottomNavigationEvent{
  @override
  String toString() => 'AppRepositories';

  @override
  List<Object> get props => [];
}

class PageTapped extends BottomNavigationEvent {
  final int index;

  PageTapped({@required this.index}) : super([index]);

  @override
  String toString() => 'PageTapped: $index';

  @override
  List<Object> get props => [];
}
