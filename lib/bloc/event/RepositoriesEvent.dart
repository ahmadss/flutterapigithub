import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class RepositoriesEvent extends Equatable{
  const RepositoriesEvent();
  @override
  List<Object> get props => [];
}

class FetchRepositoriesEvent extends RepositoriesEvent{
  String searchQuery;

  FetchRepositoriesEvent(@required this.searchQuery);
  @override
  List<Object> get props => [];
}

class FetchRepositoriesLoadMoreEvent extends RepositoriesEvent {
  final int start, limit;
  String searchQuery;
  FetchRepositoriesLoadMoreEvent({@required this.searchQuery,
    @required this.start, @required this.limit});

  @override
  List<Object> get props => [start, limit];
}
