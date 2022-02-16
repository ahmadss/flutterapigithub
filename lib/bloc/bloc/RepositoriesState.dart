import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:testgithub/model/RepositoriesModel.dart';

enum PostStatus { initial, success, failure }
abstract class RepositoriesState extends Equatable{

}

class RepositoriesInitialState extends RepositoriesState{
  @override
  List<Object> get props => [];
}

class RepositoriesLoadingState extends RepositoriesState{
  @override
  List<Object> get props => [];
}

class RepositoriesLoadingMoreState extends RepositoriesState{
  @override
  List<Object> get props => [];
}

class RepositoriesLoadedState extends RepositoriesState{
  final List<RepositoriesModel> repositoriesList;
  final int count;

  RepositoriesLoadedState({
    @required this.repositoriesList,
    @required this.count,
  });

  @override
  List<Object> get props => [repositoriesList, count];
}

class RepositoriesErrorState extends RepositoriesState{
  String message;

  RepositoriesErrorState({@required this.message});
  @override
  List<Object> get props => [message];
}
