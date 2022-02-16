
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:testgithub/model/ContributorsModel.dart';

abstract class ContributorsState extends Equatable{

}

class ContributorsListInitialState extends ContributorsState{
  @override
  List<Object> get props => [];
}

class ContributorsListLoadingState extends ContributorsState{
  @override
  List<Object> get props => [];
}

class ContributorsListLoadingMoreState extends ContributorsState{
  @override
  List<Object> get props => [];
}

class ContributorsListLoadedState extends ContributorsState{
  final List<ContributorsModel> list;
  final int count;

  ContributorsListLoadedState({
    @required this.count,
    @required this.list,
  });

  @override
  List<Object> get props => [list, count];
}

class ContributorsListErrorState extends ContributorsState{
  String message;

  ContributorsListErrorState({@required this.message});
  @override
  List<Object> get props => [message];
}